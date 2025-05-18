import 'package:flutter/material.dart';
import 'package:naruto_app/data/models/clan.dart'; // Importa el modelo ClanModel

// Este widget muestra los detalles de un clan seleccionado.
class ClanDetailScreen extends StatelessWidget {
  final ClanModel clan; // Declara clan como final y obligatorio

  const ClanDetailScreen({Key? key, required this.clan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(clan.name)), // Muestra el nombre del clan en la AppBar
      body: Padding(
        padding: const EdgeInsets.all(
            16.0), // Añade un padding alrededor del contenido
        child: _ClanDetailContent(
            clan: clan), // Llama al widget que muestra el contenido del detalle
      ),
    );
  }
}

// Este widget muestra el contenido de la pantalla de detalles del clan.
class _ClanDetailContent extends StatelessWidget {
  final ClanModel clan;

  const _ClanDetailContent({required this.clan});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Alinea el contenido a la izquierda
      children: [
        Text(
          clan.name,
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold), // Estilo del nombre del clan
        ),
        const SizedBox(height: 16),
        const Text(
          'Descripción:',
          style: TextStyle(
              fontWeight:
                  FontWeight.bold), // Estilo del título de la descripción
        ),
        Text(clan.description ??
            'Sin descripción'), // Muestra la descripción o "Sin descripción" si es nula
        const SizedBox(height: 16),
        const Text(
          'Población:',
          style: TextStyle(
              fontWeight: FontWeight.bold), // Estilo del título de la población
        ),
        Text('${clan.population}'), // Muestra la población del clan
      ],
    );
  }
}
