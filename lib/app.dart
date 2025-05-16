import 'package:flutter/material.dart';
import 'presentation/characters/screens/character_list_screen.dart';
import 'presentation/clans/screens/clan_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naruto App',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: DefaultTabController(
        // Eliminamos const de aquí
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Naruto Universe'),
            bottom: TabBar(
              tabs: [const Tab(text: 'Characters'), const Tab(text: 'Clans')],
            ),
          ),
          body: TabBarView(children: [CharacterListScreen(), ClanListScreen()]),
        ),
      ),
    );
  }
}
