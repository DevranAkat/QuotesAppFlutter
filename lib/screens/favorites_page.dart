import 'package:flutter/material.dart';
import 'package:motivation/widgets/left_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../quotes/quote.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Favorites'),
      ),
      body: LikedQuotes(),
      drawer: const LeftMenu(),
    );
  }
}

class LikedQuotes extends StatefulWidget {
  const LikedQuotes({super.key});

  @override
  State<LikedQuotes> createState() => _LikedQuotesState();
}

class _LikedQuotesState extends State<LikedQuotes> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var quotesLiked = [];
  var isLiked = true;

  void getLikedQuotesList() async{
    final SharedPreferences prefs = await _prefs;
    setState(() {
      quotesLiked = prefs.getStringList("likedQuotes") ?? [];
    });
  }

  Future<void> toggleLike(id) async {
    final SharedPreferences prefs = await _prefs;
    var likedQuotes = prefs.getStringList("likedQuotes") ?? [];
    isLiked ? likedQuotes.remove(id.toString()) : likedQuotes.add(id.toString());
    prefs.setStringList("likedQuotes", likedQuotes);

    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  initState() {
    getLikedQuotesList();
  }
  
  @override
  Widget build(BuildContext context) {
    

  // getLikedQuotes();
    return ListView.builder(
      itemCount: quotesLiked.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
          //quotes[1].text,
          quotes[int.parse(quotesLiked[index])].text,
            style: const TextStyle(
                color: Colors.white, // Text color
                fontSize: 20.0, // Adjust font size as needed
              ),
            ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    toggleLike(index);
                  });
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                onPressed: () {
                },
              ),
            ],
          ),
        );
      },
    );
  }
}