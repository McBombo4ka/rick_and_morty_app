import '../../core/network/network_info.dart';
import '../../data/sources/remote/character_remote_source.dart';
import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';

import '../../core/results.dart';
import '../sources/local/character_local_sources.dart';

class CharacterRepositoryImplement implements CharacterRepository {
  final CharacterRemoteSource remote;
  final CharacterLocalSource local;
  final NetworkInfo networkInfo;

  CharacterRepositoryImplement({
    required this.remote,
    required this.local,
    required this.networkInfo,
  });

  @override
  Future<Result<List<Character>>> getCharacters(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteModels = await remote.fetchCharactersPage(page);

        await local.cacheCharacters(remoteModels);

        final entities = remoteModels.map((e) => e.toEntity()).toList();

        return Result.success(entities);
      } catch (_) {
        return Result.failure("Нет данных");
      }
    } else {
      final cached = await local.getCachedCharacters(page);
      if (cached.isNotEmpty) {
        return Result.success(cached.map((e) => e.toEntity()).toList());
      }
      return Result.failure("Нет доступа к интернету. Кеш пуст");
    }
  }
   @override
  Future<void> toggleFavorite(int id) async {
    final currently = (await local.getFavoriteModels()).any((m) => m.id == id);
    await local.setFavorite(id, !currently);
  }

  @override
  Future<List<Character>> getFavorites() async {
    final models = await local.getFavoriteModels();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Stream<List<Character>> watchFavorites() {
    return local.watchFavorites().map((models) => models.map((m) => m.toEntity()).toList());
  }
}
