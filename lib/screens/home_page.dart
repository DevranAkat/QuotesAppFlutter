import 'package:flutter/material.dart';
import 'package:motivation/widgets/left_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu), 
          onPressed: _openDrawer,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active), 
            onPressed: () {
              _openSettingsPanel(context); 
            },
          ),
        ],
      ),
      drawer: const LeftMenu(),
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
                      onPressed:  _toggleLike,
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