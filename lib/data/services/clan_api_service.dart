import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:naruto_app/data/models/clan.dart';

class ClanService {
  final String baseUrl = 'https://api-dattebayo.vercel.app/api/v1';

  Future<List<ClanModel>> fetchClans({int limit = 10, int offset = 0}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/clans?limit=$limit&offset=$offset'),
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final List<dynamic> data =
          jsonBody['data']; // Ajusta si la API responde con un objeto
      return data.map((json) => ClanModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los clanes');
    }
  }
}
