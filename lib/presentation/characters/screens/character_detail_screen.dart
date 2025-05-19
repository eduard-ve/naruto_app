import 'package:flutter/material.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Map<String, dynamic> character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character['name'] ?? 'Personaje')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (character['images'] != null && character['images'].isNotEmpty)
              Image.network(character['images'][0], height: 200),
            const SizedBox(height: 16),
            Text('Nombre: ${character['name'] ?? ''}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            if (character['personal'] != null) ...[
              Text('Ocupación: ${character['personal']['occupation'] ?? ''}'),
              Text('Afiliación: ${character['personal']['affiliation'] ?? ''}'),
              Text('Clan: ${character['personal']['clan'] ?? ''}'),
            ],
            if (character['jutsu'] != null)
              Text('Jutsu: ${(character['jutsu'] as List).join(", ")}'),
            if (character['natureType'] != null)
              Text(
                  'Naturaleza: ${(character['natureType'] as List).join(", ")}'),
          ],
        ),
      ),
    );
  }
}
