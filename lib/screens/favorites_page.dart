import 'package:flutter/material.dart';
import 'package:motivation/widgets/left_menu.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites Page'),
      ),
      body: const Center(
        child: Text('This is the Favorites Page.'),
      ),
      drawer: const LeftMenu(),
    );
  }
}