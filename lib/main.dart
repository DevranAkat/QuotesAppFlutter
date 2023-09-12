import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLiked = false; // Track the liked state

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _openSettingsPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // Create your settings panel content here
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
               Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Add settings options here
            ],
          ),
        );
      },
    );
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked; // Toggle the liked state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background color
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove app bar shadow
        leading: IconButton(
          icon: const Icon(Icons.menu), // Menu button on the top left
          onPressed: _openDrawer,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings), // Settings button on the top right
            onPressed: () {
              _openSettingsPanel(context); // Open settings panel
            },
          ),
        ],
      ),
      drawer: Drawer(
        // Your left menu content goes here
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue, // Customize header color
              ),
              child: Text(
                'Motivation Quotes',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 24.0,
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              trailing: const Icon(Icons.home),
              onTap: () {
                // Add logic for handling menu item 1
              },
            ),
            ListTile(
              title: const Text('Favorites'),
              trailing: const Icon(Icons.favorite),
              onTap: () {
                // Add logic for handling menu item 2
              },
            ),
            // Add more menu items as needed
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0), // Space to move quote up
            const Text(
              "Your Motivational Quote Goes Here",
              style: TextStyle(
                color: Colors.white, // Text color
                fontSize: 24.0, // Adjust font size as needed
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0), // Space between quote and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.white,
                      ), // Heart-shaped like button
                      onPressed: _toggleLike,
                    ),
                    const Text(
                      'Like', // Text under the like button
                      style:  TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20.0), // Space between buttons
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white), // Share button
                      onPressed: () {
                        // Add logic for sharing the quote
                      },
                    ),
                    const Text(
                      'Share', // Text under the share button
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}