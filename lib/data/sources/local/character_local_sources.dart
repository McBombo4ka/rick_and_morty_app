import 'package:hive_flutter/hive_flutter.dart';
import '../../models/character_model.dart';

abstract class CharacterLocalSource {
  Future<List<CharacterModel>> getCachedCharacters(int page);
  Future<void> cacheCharacters(List<CharacterModel> characters);
  Future<void> appendCharacters(List<CharacterModel> characters);
  Future<List<CharacterModel>> getAllCached(); // helper для отладки

  Future<void> setFavorite(int id, bool value);
  Future<List<CharacterModel>> getFavoriteModels();
  Stream<List<CharacterModel>> watchFavorites();
}

class CharacterLocalSourceImplement implements CharacterLocalSource {
  final Box<CharacterModel> box;

  CharacterLocalSourceImplement(this.box);

  static const pageSize = 20;

  @override
  Future<List<CharacterModel>> getCachedCharacters(int page) async {
    if (page < 1) page = 1;

    final all = box.values.toList()
      ..sort((a, b) => a.id.compareTo(b.id));

    final start = (page - 1) * pageSize;
    final end = start + pageSize;

    if (start >= all.length) return [];

    return all.sublist(start, end > all.length ? all.length : end);
  }

  @override
  Future<void> cacheCharacters(List<CharacterModel> characters) async {
    // Upsert-подход: сохраняем модель по ключу id, но если запись уже есть,
    // сохраняем прежний isFavorite.
    for (final ch in characters) {
      final existing = box.get(ch.id);
      final preservedFavorite = existing?.isFavorite ?? false;

      final toSave = CharacterModel(
        id: ch.id,
        name: ch.name,
        status: ch.status,
        imageURL: ch.imageURL,
        isFavorite: preservedFavorite,
      );

      await box.put(ch.id, toSave);
    }
  }

  @override
  Future<void> appendCharacters(List<CharacterModel> characters) async {
    // append с дедупликацией (если нужно)
    for (final ch in characters) {
      if (!box.containsKey(ch.id)) {
        await box.put(ch.id, ch);
      }
    }
  }

  @override
  Future<List<CharacterModel>> getAllCached() async {
    return box.values.toList();
  }

   @override
  Future<void> setFavorite(int id, bool value) async {
    final existing = box.get(id);
    if (existing == null) return;
    await box.put(id, existing.copyWith(isFavorite: value));
  }

  @override
  Future<List<CharacterModel>> getFavoriteModels() async {
    return box.values.where((e) => e.isFavorite).toList();
  }

  @override
  Stream<List<CharacterModel>> watchFavorites() async* {
    // сначала текущее состояние
    yield box.values.where((e) => e.isFavorite).toList();
    // дальше — события
    await for (final _ in box.watch()) {
      yield box.values.where((e) => e.isFavorite).toList();
    }
  }
}
