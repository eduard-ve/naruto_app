import 'package:flutter/material.dart';
import 'package:naruto_app/data/models/clan.dart';
import 'package:naruto_app/data/services/clan_api_service.dart';
import 'package:naruto_app/presentation/clans/screens/clan_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

// Este widget muestra la lista de clanes
class ClanListScreen extends StatelessWidget {
  const ClanListScreen({super.key});

  // Logger instance
  static final logger = Logger();

  // Función para obtener los nombres de los personajes por sus IDs usando la API correcta
  Future<List<String>> fetchCharacterNames(List<int> ids) async {
    if (ids.isEmpty) return [];
    final idsString = ids.join(',');
    final url = 'https://dattebayo-api.onrender.com/characters/$idsString';
    logger.i('GET $url');
    final response = await http.get(Uri.parse(url));
    logger.i('Status: ${response.statusCode}');
    logger.i('Body: ${response.body}');
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final List<dynamic> data =
          jsonBody is List ? jsonBody : jsonBody['characters'];
      return data.map<String>((char) => char['name'] as String).toList();
    } else {
      logger.e('Error al cargar personajes: ${response.body}');
      throw Exception('Error al cargar personajes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clanes'),
      ),
      body: FutureBuilder<List<ClanModel>>(
        future: ClanService().fetchClans(), // <-- ya no usa paginación
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay clanes disponibles'));
          }

          final clans = snapshot.data!;

          return ListView.builder(
            itemCount: clans.length,
            itemBuilder: (context, index) {
              final clan = clans[index];

              return ListTile(
                leading: CircleAvatar(
                  child: Text(clan.name[0]),
                ),
                title: Text(clan.name),
                subtitle: FutureBuilder<List<String>>(
                  future: fetchCharacterNames(clan.characters),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Cargando personajes...');
                    } else if (snapshot.hasError) {
                      return const Text('Error al cargar personajes');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('Sin personajes');
                    }
                    final names = snapshot.data!;
                    return Text(
                        'ID: ${clan.id}\nPersonajes: ${names.join(', ')}');
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClanDetailScreen(clan: clan),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
