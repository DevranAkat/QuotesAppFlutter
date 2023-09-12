import 'package:flutter/material.dart';

class LeftMenu extends StatelessWidget {
  const LeftMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Your left menu content goes here
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black87, // Customize header color
            ),
            child: Center(
              child: Text(
                'Motivation Quotes',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
            },
          ),
          ListTile(
            title: const Text('Categories'),
            leading: const Icon(Icons.category),
            onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/categories', (route) => false);
            },
          ),
          ListTile(
            title: const Text('Favorites'),
            leading: const Icon(Icons.favorite),
            onTap: () {
              Navigator.of(context).pushNamed('/favorites');
            },
          ),
          // Add more menu items as needed
        ],
      ),
    );
  }
}