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
  final List<Character> _characters = [];
  final ScrollController _scrollController = ScrollController();

  int _currentPage = 1;
  bool _isLoading = true;
  bool _isFetchingMore = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !_isFetchingMore &&
        !_isLoading) {
      _loadMoreCharacters();
    }
  }

  Future<void> _loadCharacters() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final characters = await _characterService.getCharacters(page: _currentPage);

      setState(() {
        _characters.addAll(characters);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMoreCharacters() async {
    setState(() {
      _isFetchingMore = true;
    });

    try {
      final nextPage = _currentPage + 1;
      final moreCharacters = await _characterService.getCharacters(page: nextPage);

      if (moreCharacters.isNotEmpty) {
        setState(() {
          _currentPage = nextPage;
          _characters.addAll(moreCharacters);
        });
      }
    } catch (e) {
      // Error silencioso o mostrar mensaje si se desea
    } finally {
      setState(() {
        _isFetchingMore = false;
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
    if (_isLoading && _characters.isEmpty) {
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
              onPressed: () {
                _currentPage = 1;
                _characters.clear();
                _loadCharacters();
              },
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
      onRefresh: () async {
        _currentPage = 1;
        _characters.clear();
        await _loadCharacters();
      },
      child: GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _characters.length + (_isFetchingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _characters.length) {
            return CharacterCard(character: _characters[index]);
          } else {
            // Muestra indicador de carga al final mientras carga más
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
