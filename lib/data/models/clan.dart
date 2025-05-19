class ClanModel {
  final int id;
  final String name;
  final List<int> characters;

  ClanModel({
    required this.id,
    required this.name,
    required this.characters,
  });

  factory ClanModel.fromJson(Map<String, dynamic> json) {
    return ClanModel(
      id: json['id'],
      name: json['name'],
      characters: List<int>.from(json['characters']),
    );
  }
}
