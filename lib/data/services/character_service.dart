import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:naruto_app/data/models/character.dart';

class CharacterService {
  final String baseUrl = 'https://dattebayo-api.onrender.com';

  Future<List<Character>> getCharacters() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/characters'));
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      final List<dynamic> data = jsonBody['characters'];
      return data.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching characters: $e');
  }
}
  Future<Character> getCharacterById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/characters/$id'));
      
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return Character.fromJson(data);
      } else {
        throw Exception('Failed to load character: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching character: $e');
    }
  }
}