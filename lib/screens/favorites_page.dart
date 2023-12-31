import 'package:flutter/material.dart';
import 'package:motivation/widgets/left_menu.dart';
import 'package:motivation/widgets/share_button.dart';
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
  List<Quote> quotesLiked = [];

  void getLikedQuotesList() async{
    final SharedPreferences prefs = await _prefs;
    setState(() {
      var likedQuotes = prefs.getStringList("likedQuotes") ?? [];
      quotesLiked = quotes.where((quote) => likedQuotes.contains(quote.id.toString())).toList();
    });
  }

  Future<void> toggleLike(id) async {
    final SharedPreferences prefs = await _prefs;
    var likedQuotes = prefs.getStringList("likedQuotes") ?? [];
    likedQuotes.contains(id.toString()) ? likedQuotes.remove(id.toString()) : likedQuotes.add(id.toString());
    prefs.setStringList("likedQuotes", likedQuotes);
    print(likedQuotes);

    setState(() {
      quotesLiked.firstWhere((element) => element.id == id).liked = likedQuotes.contains(id.toString());
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
          quotesLiked[index].text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: FavoriteIcon(isLiked: quotesLiked[index].liked),
                onPressed: () {
                  setState(() {
                    toggleLike(quotesLiked[index].id);
                  });
                },
              ),
              ShareButton(onPressed: () => Share.share(quotesLiked[index].text)),
            ],
          ),
        );
      },
    );
  }
}