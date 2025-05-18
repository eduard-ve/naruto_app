import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:naruto_app/data/models/clan.dart';
import 'package:logger/logger.dart'; // Importa el paquete logger

class ClanService {
  final String baseUrl = 'https://dattebayo-api.onrender.com/clans';

  Future<List<ClanModel>> fetchClans({int limit = 10, int offset = 0}) async {
    final url = Uri.parse('$baseUrl?limit=$limit&offset=$offset');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final jsonBody = json.decode(response.body);
        final List<dynamic> data = jsonBody['clans'];
        return data.map((json) => ClanModel.fromJson(json)).toList();
      } catch (e) {
        Logger().e('Error al decodificar JSON: $e',
            error: e); // Usa Logger().e con argumento nombrado
        throw Exception('Error al decodificar JSON: $e');
      }
    } else {
      Logger().e(
          // Usa Logger().e con argumentos nombrados
          'Error al cargar clanes: Status code: ${response.statusCode}, Body: ${response.body}',
          error: response
              .statusCode); // Puedes pasar el código de estado como error
      throw Exception('Error al cargar clanes: ${response.statusCode}');
    }
  }
}
