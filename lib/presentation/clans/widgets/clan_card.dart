import 'package:flutter/material.dart';
import 'package:naruto_app/data/models/clan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

// Este widget muestra el contenido de la pantalla de detalles del clan.
class _ClanDetailContent extends StatelessWidget {
  final ClanModel clan;

  const _ClanDetailContent({required this.clan});

  Future<List<String>> fetchCharacterNames(List<int> ids) async {
    final response = await http.get(
      Uri.parse(
        'https://api-dattebayo.vercel.app/api/v1/characters?ids=${ids.join(",")}',
      ),
    );
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final List<dynamic> data = jsonBody['data'];
      return data.map<String>((char) => char['name'] as String).toList();
    } else {
      throw Exception('Error al cargar los personajes');
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
