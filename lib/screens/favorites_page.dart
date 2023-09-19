import 'package:flutter/material.dart';
import 'package:motivation/widgets/left_menu.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../quotes/quote.dart';
import '../widgets/favorite_icon.dart';

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
      body: const LikedQuotes(),
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
  List<bool> isLikedList = [];

  void getLikedQuotesList() async{
    final SharedPreferences prefs = await _prefs;
    setState(() {
      quotesLiked = prefs.getStringList("likedQuotes") ?? [];
      isLikedList = quotesLiked.map((id) => true).toList();
    });
  }

  Future<void> toggleLike(id) async {
    final SharedPreferences prefs = await _prefs;
    var likedQuotes = prefs.getStringList("likedQuotes") ?? [];
    isLikedList[id] ? likedQuotes.remove(id.toString()) : likedQuotes.add(id.toString());;
    prefs.setStringList("likedQuotes", likedQuotes);

    setState(() {
      isLikedList[id] = !isLikedList[id]; // Toggle like status for the specific quote
    });
  }

  @override
  initState() {
    super.initState();
    getLikedQuotesList();
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: quotesLiked.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
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
                icon: FavoriteIcon(isLiked: isLikedList[index]),
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
                  Share.share(quotes[int.parse(quotesLiked[index])].text);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}