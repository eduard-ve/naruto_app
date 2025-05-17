class Character {
  final int id;
  final String name;
  final String? images;
  final String? jutsu;
  final String? personal;
  final String? uniqueTraits;

  Character({
    required this.id,
    required this.name,
    this.images,
    this.jutsu,
    this.personal,
    this.uniqueTraits,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
  final dynamic imageField = json['images'];
  String? imageUrl;

  if (imageField is List && imageField.isNotEmpty) {
    imageUrl = imageField.first.toString();
  } else if (imageField is String) {
    imageUrl = imageField;
  }

  String? jutsu;
  if (json['jutsu'] is String) {
    jutsu = json['jutsu'];
  } else if (json['jutsu'] is List && json['jutsu'].isNotEmpty) {
    jutsu = json['jutsu'].join(', ');
  }

  String? personal;
  if (json['personal'] is Map<String, dynamic>) {
    personal = json['personal']['classification']?.toString();
  }

  return Character(
    id: json['id'] ?? 0,
    name: json['name'] ?? 'Desconocido',
    images: imageUrl,
    jutsu: jutsu,
    personal: personal,
    uniqueTraits: json['uniqueTraits']?.toString(),
  );
}

}