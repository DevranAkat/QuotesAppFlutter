import 'package:flutter/material.dart';
import 'package:motivation/widgets/left_menu.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(
        elevation: 0, 
      ),
      body: const Center(
        child: Text('This is the Categories Page.'),
      ),
      drawer: const LeftMenu(),
    );
  }
}