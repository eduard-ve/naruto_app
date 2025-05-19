import 'package:flutter/material.dart';
import 'presentation/characters/screens/character_list_screen.dart';
import 'presentation/clans/screens/clan_list_screen.dart';
import 'package:naruto_app/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart'; // <-- Importa Google Fonts

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naruto App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[700],
            elevation: 4,
            title: Text(
              'Naruto Universe',
              style: GoogleFonts.bebasNeue(
                color: Colors.orangeAccent,
                fontSize: 36,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Personajes'),
                Tab(text: 'Clanes'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              CharacterListScreen(),
              ClanListScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
