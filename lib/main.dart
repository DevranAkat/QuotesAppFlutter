import 'package:flutter/material.dart';
import 'screens/categories_page.dart';
import 'screens/favorites_page.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/categories': (context) => const CategoriesPage(),
        '/favorites': (context) => const FavoritesPage(),
      },
      initialRoute: '/home'
    );
  }
}