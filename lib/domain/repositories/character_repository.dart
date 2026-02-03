import '../../core/results.dart';
import '../entities/character.dart';

/// Какой-то абстрактный класс для описания чего-то конкретного, чтобы не выходить за рамки чего-то.
abstract class CharacterRepository {
  Future<Result<List<Character>>> getCharacters(int page);

  Future<void> toggleFavorite(int id);
  Future<List<Character>> getFavorites();
  Stream<List<Character>> watchFavorites();
}