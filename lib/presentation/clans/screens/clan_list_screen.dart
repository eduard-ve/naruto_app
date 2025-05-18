import 'package:flutter/material.dart';
// Importa los modelos y servicios necesarios para obtener los datos de los clanes
import 'package:naruto_app/data/models/clan.dart';
import 'package:naruto_app/data/services/clan_api_service.dart';
// Importa la pantalla de detalles del clan
import 'package:naruto_app/presentation/clans/screens/clan_detail_screen.dart';

// Este widget muestra la lista de clanes
class ClanListScreen extends StatelessWidget {
  const ClanListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clanes'),
      ),
      body: FutureBuilder<List<ClanModel>>(
        // Usa FutureBuilder para manejar la asincronía
        future: ClanService()
            .fetchClans(), // Llama al servicio para obtener la lista de clanes
        builder: (context, snapshot) {
          // Muestra un indicador de carga mientras se obtienen los datos
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Muestra un mensaje de error si ocurre algún problema al obtener los datos
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Muestra un mensaje si no hay datos disponibles
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay clanes disponibles'));
          }

          // Si se obtienen los datos correctamente, se construye la lista
          final clans = snapshot.data!;

          return ListView.builder(
            itemCount: clans.length, // Número de clanes
            itemBuilder: (context, index) {
              final clan = clans[index]; // Obtiene el clan actual

              return ListTile(
                leading: CircleAvatar(
                  child: Text(clan
                      .name[0]), // Muestra la primera letra del nombre del clan
                ),
                title: Text(clan.name),
                subtitle: Text(clan.description ??
                    'Sin descripción'), // Muestra la descripción del clan
                trailing: Text(
                    'Población: ${clan.population}'), // Muestra la población del clan
                onTap: () {
                  // Navega a la pantalla de detalles del clan al tocarlo
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
