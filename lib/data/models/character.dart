class Character {
  final int id;
  final String name;
  final String? images;
  final List<String>? jutsu;
  final Map<String, dynamic>? personal;
  final List<String>? uniqueTraits;
  final List<String>? natureType;

  Character({
    required this.id,
    required this.name,
    this.images,
    this.jutsu,
    this.personal,
    this.uniqueTraits,
    this.natureType,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    // Imagen
    final dynamic imageField = json['images'];
    String? imageUrl;
    if (imageField is List && imageField.isNotEmpty) {
      imageUrl = imageField.first.toString();
    } else if (imageField is String) {
      imageUrl = imageField;
    }

    // Jutsu
    List<String>? jutsu;
    if (json['jutsu'] is List) {
      jutsu = (json['jutsu'] as List).map((e) => e.toString()).toList();
    } else if (json['jutsu'] is String) {
      jutsu = [json['jutsu']];
    }

    // Personal
    Map<String, dynamic>? personal;
    if (json['personal'] is Map<String, dynamic>) {
      personal = Map<String, dynamic>.from(json['personal']);
    }

    // Unique Traits
    List<String>? uniqueTraits;
    if (json['uniqueTraits'] is List) {
      uniqueTraits =
          (json['uniqueTraits'] as List).map((e) => e.toString()).toList();
    } else if (json['uniqueTraits'] is String) {
      uniqueTraits = [json['uniqueTraits']];
    }

    // Nature Type
    List<String>? natureType;
    if (json['natureType'] is List) {
      natureType =
          (json['natureType'] as List).map((e) => e.toString()).toList();
    } else if (json['natureType'] is String) {
      natureType = [json['natureType']];
    }

    return Character(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Desconocido',
      images: imageUrl,
      jutsu: jutsu,
      personal: personal,
      uniqueTraits: uniqueTraits,
      natureType: natureType,
    );
  }
}
