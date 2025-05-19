import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:naruto_app/data/models/clan.dart';
import 'package:logger/logger.dart'; // Importa el paquete logger

class ClanService {
  final String baseUrl = 'https://dattebayo-api.onrender.com/clans';

  Future<List<ClanModel>> fetchClans() async {
    final url = Uri.parse(baseUrl); // <-- Eliminado ?limit=10&offset=0
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final jsonBody = json.decode(response.body);
        final List<dynamic> data = jsonBody['clans'];
        return data.map((json) => ClanModel.fromJson(json)).toList();
      } catch (e) {
        Logger().e('Error al decodificar JSON: $e', error: e);
        throw Exception('Error al decodificar JSON: $e');
      }
    } else {
      Logger().e(
        'Error al cargar clanes: Status code: ${response.statusCode}, Body: ${response.body}',
        error: response.statusCode,
      );
      throw Exception('Error al cargar clanes: ${response.statusCode}');
    }
  }
}
