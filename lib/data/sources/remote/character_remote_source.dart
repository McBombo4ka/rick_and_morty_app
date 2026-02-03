import '../../models/character_model.dart';
import 'package:dio/dio.dart';

class CharacterRemoteSource {
  CharacterRemoteSource({required this.dio});
  final Dio dio;
  Future<List<CharacterModel>> fetchCharactersPage(int page) async {
    try {
      final response = await dio.get(
        'https://rickandmortyapi.com/api/character?page=$page',
      );
      if (response.statusCode == 200) {
        final data = response.data['results'] as List;
        return data.map((json) => CharacterModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load characters: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
