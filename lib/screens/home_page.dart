import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:motivation/quotes/quote.dart';
import 'package:motivation/widgets/favorite_icon.dart';
import 'package:motivation/widgets/left_menu.dart';

import '../widgets/like_button.dart';
import '../widgets/share_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int currentQuoteIndex = 0;

  @override
  void initState() {
    super.initState();
    setLikeOnQuotes();
  }

  void setLikeOnQuotes() async {
    final SharedPreferences prefs = await _prefs;
    var likedQuotesList = prefs.getStringList("likedQuotes") ?? [];

    for (int i = 0; i < likedQuotesList.length; i++) {
      final quote = quotes.firstWhere((element) => element.id.toString() == likedQuotesList[i]);
      quote.liked = true;
    }
  }

  Future<void> _toggleLike(int id) async {
    final SharedPreferences prefs = await _prefs;
    var likedQuotes = prefs.getStringList("likedQuotes") ?? [];

    likedQuotes.contains(id.toString()) ? likedQuotes.remove(id.toString()) : likedQuotes.add(id.toString());

    prefs.setStringList("likedQuotes", likedQuotes);
    
    setState(() {
      quotes.firstWhere((element) => element.id == id).liked = likedQuotes.contains(id.toString());
    });
  }

  void _openSettingsPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Notification settings',
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
    return Scaffold(
      backgroundColor: Colors.black,
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
        child: QuoteDisplay(
          quote: randomQuotes[currentQuoteIndex],
          isLiked: randomQuotes[currentQuoteIndex].liked,//[currentQuoteIndex],
          onLikePressed: () => _toggleLike(randomQuotes[currentQuoteIndex].id),
          onSharePressed: () {
            Share.share(randomQuotes[currentQuoteIndex].text);
          },
          onPreviousPressed: () {
            setState(() {
              currentQuoteIndex = (currentQuoteIndex - 1) % randomQuotes.length;
            });
            // checkIfLiked();
          },
          onNextPressed: () {
            setState(() {
              currentQuoteIndex = (currentQuoteIndex + 1) % randomQuotes.length;
            });
            // checkIfLiked();
          },
        ),
      ),
    );
  }
}


class QuoteDisplay extends StatelessWidget {
  final Quote quote;
  final bool isLiked;
  final VoidCallback onLikePressed;
  final VoidCallback onSharePressed;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;

  const QuoteDisplay({super.key, 
    required this.quote,
    required this.isLiked,
    required this.onLikePressed,
    required this.onSharePressed,
    required this.onPreviousPressed,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50.0),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            quote.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LikeButton(
              isLiked: isLiked,
              onPressed: onLikePressed,
            ),
            const SizedBox(width: 20.0),
            ShareButton(
              onPressed: onSharePressed,
            ),
          ],
        ),
        const SizedBox(height: 75.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust as needed
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
              child: SizedBox(
                width: 60.0, // Adjust the width as needed
                height: 60.0, // Adjust the height as needed
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 60.0), // Adjust the icon size as needed
                  onPressed: onPreviousPressed,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
              child: SizedBox(
                width: 60.0, // Adjust the width as needed
                height: 60.0, // Adjust the height as needed
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 60.0), // Adjust the icon size as needed
                  onPressed: onNextPressed,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

