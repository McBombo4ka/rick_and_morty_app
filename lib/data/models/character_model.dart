import '../../domain/entities/character.dart';
import 'package:hive/hive.dart';

part 'character_model.g.dart';

@HiveType(typeId: 0)
class CharacterModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final String imageURL;

  // NEW: флаг избранного, индекс поля 4
  @HiveField(4)
  final bool isFavorite;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.imageURL,
    this.isFavorite = false,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      imageURL: json['image'] as String,
      isFavorite: false, // remote не даёт isFavorite — по умолчанию false
    );
  }

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      status: status,
      imageURL: imageURL,
      isFavorite: isFavorite,
    );
  }

  CharacterModel copyWith({bool? isFavorite}) => CharacterModel(
    id: id,
    name: name,
    status: status,
    imageURL: imageURL,
    isFavorite: isFavorite ?? this.isFavorite,
  );
}
