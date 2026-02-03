// lib/data/usecases/get_character.dart

import '../../core/results.dart';
import '../repositories/character_repository.dart';
import '../entities/character.dart';

/// Это то, чем мы можем пользоваться и чем нужно пользоваться.
/// Тут находятся методы(?) для получения нужных данных.
/// Получаем пока только данные о персонажах.
class GetCharacterUseCase {
  final CharacterRepository repository;
  GetCharacterUseCase(this.repository);

  Future<Result<List<Character>>> execute(int page) async {
    return await repository.getCharacters(page);
  }
}
