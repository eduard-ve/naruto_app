import 'package:flutter/material.dart';
// Importa las pantallas que vamos a usar
import 'package:naruto_app/presentation/characters/screens/character_list_screen.dart';
import 'package:naruto_app/presentation/clans/screens/clan_list_screen.dart';
import 'package:naruto_app/theme/app_theme.dart';
import 'package:naruto_app/theme/app_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naruto App', // Título de la aplicación
      theme: AppTheme.lightTheme, // Tema claro de la aplicación
      darkTheme: AppTheme.darkTheme, // Tema oscuro de la aplicación
      themeMode: ThemeMode.system, // Usa el tema del sistema (claro u oscuro)
      home: DefaultTabController(
        length: 2, // Número de pestañas
        child: Scaffold(
          appBar: AppBar(
            // Remueve const de aquí
            title: Text('Naruto Universe',
                style: AppStyles.titleLarge), // Título de la AppBar
            bottom: const TabBar(
              // Barra de pestañas en la parte inferior de la AppBar
              tabs: [
                Tab(text: 'Characters'), // Pestaña de Personajes
                Tab(text: 'Clans'), // Pestaña de Clanes
              ],
            ),
          ),
          body: TabBarView(
            // Muestra el contenido de cada pestaña
            children: [
              CharacterListScreen(), // Pantalla de la lista de personajes
              ClanListScreen(), // Pantalla de la lista de clanes
            ],
          ),
        ),
      ),
    );
  }
}
