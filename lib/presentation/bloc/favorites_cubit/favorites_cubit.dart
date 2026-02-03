import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/character.dart';
import '../../../domain/repositories/character_repository.dart';

class FavoritesCubit extends Cubit<List<Character>> {
  final CharacterRepository repository;
  StreamSubscription<List<Character>>? _sub;

  FavoritesCubit(this.repository) : super([]) {
    _init();
  }

  Future<void> _init() async {
    final current = await repository.getFavorites();
    emit(current);
    _sub = repository.watchFavorites().listen((list) => emit(list));
  }

  Future<void> toggle(int id) async {
    await repository.toggleFavorite(id);
    // watchFavorites() обновит состояние автоматически
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
