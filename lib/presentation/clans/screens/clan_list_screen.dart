import 'package:flutter/material.dart';
import '../../../../data/models/clan.dart';
import 'package:naruto_app/data/services/clan_api_service.dart';

class ClanListScreen extends StatelessWidget {
  const ClanListScreen({super.key}); // <--- agrega esto

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Clanes')),
      body: FutureBuilder<List<ClanModel>>(
        future: ClanService().fetchClans(),
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
                  child:
                      Text(clan.name[0]), // Muestra la primera letra del nombre
                ),
                title: Text(clan.name),
                subtitle: Text(clan.description),
                trailing: Text('Población: ${clan.population}'),
                onTap: () {
                  // Aquí puedes navegar a la pantalla de detalles del clan
                },
              );
            },
          );
        },
      ),
    );
  }
}
