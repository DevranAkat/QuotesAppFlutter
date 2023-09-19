import 'package:flutter/material.dart';
import 'package:motivation/quotes/quote.dart';
import 'package:motivation/widgets/favorite_icon.dart';
import 'package:motivation/widgets/left_menu.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isLiked = false;
  int currentQuoteIndex = 0;

  void checkIfLiked() async{
    final SharedPreferences prefs = await _prefs;
    var likedQuotesList = prefs.getStringList("likedQuotes") ?? [];
    if (likedQuotesList.contains(currentQuoteIndex.toString())) {
      setState(() {
        isLiked = true;
      });
    }
    else{
      isLiked = false;
    }
  }

  Future<void> _toggleLike(id) async {
    final SharedPreferences prefs = await _prefs;
    var likedQuotes = prefs.getStringList("likedQuotes") ?? [];
    isLiked ? likedQuotes.remove(id.toString()) : likedQuotes.add(id.toString());
    prefs.setStringList("likedQuotes", likedQuotes);

    setState(() {
      isLiked = !isLiked;
    });
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

  @override
  Widget build(BuildContext context) {
    checkIfLiked();
    return Scaffold(
      backgroundColor: Colors.black, // Dark background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
            const SizedBox(height: 50.0), // Space to move quote up
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                quotes[currentQuoteIndex].text,
                style: const TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 20.0, // Adjust font size as needed
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20.0), // Space between quote and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: FavoriteIcon(isLiked: isLiked), // Heart-shaped like button
                      onPressed: () =>  _toggleLike(currentQuoteIndex),
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
                        Share.share(quotes[currentQuoteIndex].text);
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
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentQuoteIndex = currentQuoteIndex - 1;
                    });
                    checkIfLiked();
                  },
                  child: const Text('Previous  Quote'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentQuoteIndex = currentQuoteIndex + 1;
                    });
                    checkIfLiked();
                  },
                  child: const Text('Next Quote'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}