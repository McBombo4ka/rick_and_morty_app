import 'package:bloc/bloc.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/entities/character.dart';
import '../../../domain/usecases/get_character.dart';
import 'package:meta/meta.dart';

import '../../../data/sources/local/character_local_sources.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharacterUseCase _getCharacters;
  final CharacterLocalSource _localSource;
  final NetworkInfo networkInfo;

  // Приватные поля реализации
  int _currentPage = 0;
  bool _isFetching = false;
  bool _hasReachedMax = false;
  
  final List<Character> _characters = [];

  // Геттеры (если потребуется внешний доступ)
  List<Character> get characters => List.unmodifiable(_characters);
  int get currentPage => _currentPage;
  bool get hasReachedMax => _hasReachedMax;

  CharacterBloc(
    this._getCharacters, {
    required CharacterLocalSource localSource, required this.networkInfo,
  })  : _localSource = localSource,
        super(CharacterInitial()) {
    on<LoadCharacters>(_onLoadCharacter);
    on<ReloadCharacters>(_onReloadCharacters);
  }

  Future<void> _onLoadCharacter(
  LoadCharacters event,
  Emitter<CharacterState> emit,
) async {
  if (_isFetching || _hasReachedMax) return;
  _isFetching = true;
  final nextPage = _currentPage + 1;

  if (_characters.isEmpty) {
    emit(CharacterLoading());
  } else {
    if (state is CharacterLoaded) {
      emit((state as CharacterLoaded).copyWith(isLoadingMore: true));
    } else {
      emit(CharacterLoading());
    }
  }

  try {
    final connected = await networkInfo.isConnected;

    if (connected) {
      // Интернет есть — онлайн-запрос
      final result = await _getCharacters.execute(nextPage);

      if (result.isSuccess) {
        final fetched = result.data!;
        if (fetched.isEmpty) {
          _hasReachedMax = true;
        } else {
          _characters.addAll(fetched);
          _currentPage = nextPage;
        }

        emit(
          CharacterLoaded(
            characters: List.from(_characters),
            isLoadingMore: false,
          ),
        );
      } else {
        // Онлайн-запрос упал — пробуем кэш
        await _loadFromCache(nextPage, emit, result.error!);
      }
    } else {

      // Нет сети — сразу кэш
      await _loadFromCache(nextPage, emit, "Нет сети");
    }
  } catch (e) {
    if (_characters.isEmpty) {
      emit(CharacterError(e.toString()));
    } else {
      if (state is CharacterLoaded) {
        emit((state as CharacterLoaded).copyWith(isLoadingMore: false));
      } else {
        emit(
          CharacterLoaded(
            characters: List.from(_characters),
            isLoadingMore: false,
          ),
        );
      }
    }
  } finally {
    _isFetching = false;
  }
}

// Вынесем логику подгрузки кэша в отдельный приватный метод
Future<void> _loadFromCache(
  int page,
  Emitter<CharacterState> emit,
  String errorMessage,
) async {
  final cached = await _localSource.getCachedCharacters(page);

  if (cached.isNotEmpty) {
    _characters.addAll(cached.map((e) => e.toEntity()));
    _currentPage = page;

    emit(
      CharacterLoaded(
        characters: List.from(_characters),
        isLoadingMore: false,
      ),
    );
  } else {
    if (_characters.isEmpty) {
      emit(CharacterError(errorMessage));
    } else {
      if (state is CharacterLoaded) {
        emit((state as CharacterLoaded).copyWith(isLoadingMore: false));
      } else {
        emit(
          CharacterLoaded(
            characters: List.from(_characters),
            isLoadingMore: false,
          ),
        );
      }
    }
  }
}



  Future<void> _onReloadCharacters(
    ReloadCharacters event,
    Emitter<CharacterState> emit,
  ) async {
    // Полный сброс состояния для "pull to refresh" / перезапуска списка
    _isFetching = false;
    _currentPage = 0;
    _hasReachedMax = false;
    _characters.clear();

    emit(CharacterLoading());

    // Запускаем загрузку первой страницы
    add(LoadCharacters());
  }
}
