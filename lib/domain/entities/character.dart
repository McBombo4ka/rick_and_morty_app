class Character {
  Character({
    required this.id,
    required this.imageURL,
    required this.name,
    required this.status,
    required this.isFavorite
  });
  final int id;
  final String imageURL;
  final String name;
  final String status;
  final bool isFavorite;
}
  