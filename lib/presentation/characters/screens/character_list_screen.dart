import 'package:flutter/material.dart';
import 'package:naruto_app/data/services/character_service.dart';
import 'package:naruto_app/data/models/character.dart';
import 'package:naruto_app/presentation/characters/widgets/character_card.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final CharacterService _characterService = CharacterService();
  List<Character> _characters = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      
      final characters = await _characterService.getCharacters();
      
      setState(() {
        _characters = characters;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personajes - Lista',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadCharacters,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (_characters.isEmpty) {
      return const Center(
        child: Text('No se encontraron personajes'),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadCharacters,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _characters.length,
        itemBuilder: (context, index) {
          return CharacterCard(character: _characters[index]);
        },
      ),
    );
  }
}