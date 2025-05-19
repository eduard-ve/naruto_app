import 'package:flutter/material.dart';
import 'package:naruto_app/data/models/clan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

// Este widget muestra los detalles de un clan seleccionado.
class ClanDetailScreen extends StatelessWidget {
  final ClanModel clan;

  const ClanDetailScreen({Key? key, required this.clan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clan.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _ClanDetailContent(clan: clan),
      ),
    );
  }
}

class _ClanDetailContent extends StatelessWidget {
  final ClanModel clan;
  static final logger = Logger();

  const _ClanDetailContent({required this.clan});

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
      // Si la respuesta es una lista de personajes:
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          clan.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'ID: ${clan.id}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Text(
          'Personajes:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        FutureBuilder<List<String>>(
          future: fetchCharacterNames(clan.characters),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error al cargar personajes');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('Sin personajes');
            }
            final names = snapshot.data!;
            return Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: names.map((name) => Chip(label: Text(name))).toList(),
            );
          },
        ),
      ],
    );
  }
}
