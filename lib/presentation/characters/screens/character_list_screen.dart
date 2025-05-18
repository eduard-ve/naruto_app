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
  // Instancia del servicio para obtener los datos de los personajes
  final CharacterService _characterService = CharacterService();
  // Lista para almacenar los personajes obtenidos
  List<Character> _characters = [];
  // Estado para indicar si se están cargando los datos
  bool _isLoading = true;
  // Estado para almacenar cualquier error que ocurra durante la carga de datos
  String? _error;

  @override
  void initState() {
    super.initState();
    // Llama a la función para cargar los personajes al inicializar el estado del widget
    _loadCharacters();
  }

  // Función asíncrona para cargar los personajes desde el servicio
  Future<void> _loadCharacters() async {
    try {
      setState(() {
        _isLoading =
            true; // Establece el estado de carga a verdadero antes de iniciar la carga
        _error = null; // Limpia cualquier error previo
      });

      // Llama al servicio para obtener la lista de personajes
      final characters = await _characterService.getCharacters();

      setState(() {
        _characters =
            characters; // Actualiza la lista de personajes con los datos obtenidos
        _isLoading =
            false; // Establece el estado de carga a falso después de cargar los datos
      });
    } catch (e) {
      // Captura cualquier error que ocurra durante la carga de datos
      setState(() {
        _error = e.toString(); // Almacena el mensaje de error
        _isLoading =
            false; // Establece el estado de carga a falso en caso de error
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
      // Llama a la función _buildBody() para construir el cuerpo de la pantalla basado en el estado
      body: _buildBody(),
    );
  }

  // Función para construir el cuerpo de la pantalla basado en el estado de carga y error
  Widget _buildBody() {
    if (_isLoading) {
      // Muestra un indicador de carga si los datos se están cargando
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      // Muestra un mensaje de error si ocurre un error durante la carga de datos
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error'), // Muestra el mensaje de error
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  _loadCharacters, // Botón para reintentar la carga de datos
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (_characters.isEmpty) {
      // Muestra un mensaje si no se encontraron personajes
      return const Center(
        child: Text('No se encontraron personajes'),
      );
    }

    // Muestra la lista de personajes si los datos se cargaron correctamente
    return RefreshIndicator(
      onRefresh:
          _loadCharacters, // Permite recargar la lista deslizando hacia abajo
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Número de columnas en la cuadrícula
          childAspectRatio:
              0.75, // Relación de aspecto de cada elemento de la cuadrícula
          crossAxisSpacing: 16, // Espacio entre columnas
          mainAxisSpacing: 16, // Espacio entre filas
        ),
        itemCount: _characters.length, // Número de personajes en la lista
        itemBuilder: (context, index) {
          // Construye una tarjeta de personaje para cada personaje en la lista
          return CharacterCard(character: _characters[index]);
        },
      ),
    );
  }
}
