part of 'character_bloc.dart';

@immutable
sealed class CharacterState {}

final class CharacterInitial extends CharacterState {}

final class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  CharacterLoaded({
    required this.characters,
    this.isLoadingMore = false,
    this.paginationError,
  });
  final List<Character> characters;
  final bool isLoadingMore; // Для индикатора внизу списка
  final String? paginationError; // Для снэкбара

  List<Object?> get props => [characters, isLoadingMore, paginationError];

  CharacterLoaded copyWith({
    List<Character>? characters,
    bool? isLoadingMore,
    String? paginationError,
  }) {
    return CharacterLoaded(
      characters: characters ?? this.characters,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      paginationError: paginationError,
    );
  }
}

class CharacterError extends CharacterState {
  CharacterError(this.message);
  final String message;
}
