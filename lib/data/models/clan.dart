class ClanModel {
  final int id;
  final String name;
  final String? description;
  final List<int> characters;
  final int? population;

  ClanModel({
    required this.id,
    required this.name,
    this.description,
    required this.characters,
    this.population,
  });

  factory ClanModel.fromJson(Map<String, dynamic> json) {
    return ClanModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      characters: List<int>.from(json['characters']),
      population: json['population'],
    );
  }
}
