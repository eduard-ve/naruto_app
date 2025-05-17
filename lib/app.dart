import 'package:flutter/material.dart';
import 'presentation/characters/character_list_screen.dart';
import 'presentation/clans/clan_list_screen.dart'; 
import 'package:tu_app/theme/app_theme.dart';

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
            title: Text('Naruto Universe', style: AppStyles.titleLarge), 
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Characters'),
                Tab(text: 'Clans'),
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