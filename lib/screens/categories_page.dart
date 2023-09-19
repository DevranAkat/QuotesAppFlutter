import 'package:flutter/material.dart';
import 'package:motivation/widgets/left_menu.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../quotes/quote.dart';
import '../widgets/favorite_icon.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String selectedCategory = '';
  List<Quote> filteredQuotes = [];
  List<bool> isLikedList = [];
  var quotesLiked = [];


  void getLikedQuotesList() async{
    final SharedPreferences prefs = await _prefs;
    setState(() {
      quotesLiked = prefs.getStringList("likedQuotes") ?? [];
      isLikedList = quotesLiked.map((id) => true).toList();
    });
  }
  
  @override
  void initState() {
    super.initState();
    filterQuotesByCategory('');
    getLikedQuotesList();
  }
  
  void filterQuotesByCategory(String category) {
    setState(() {
      selectedCategory = category;
      filteredQuotes = quotes.where((quote) => quote.category == category).toList();
    });
  }

  Widget buildCategoryButton(String category) {
    return ElevatedButton(
      onPressed: () => filterQuotesByCategory(category),
      child: Text(category),
    );
  }

  List<Widget> buildCategoryButtons() {
    List<String> categories = quotes.map((quote) => quote.category).toSet().toList();
    List<Widget> buttons = [];

    for (int i = 0; i < categories.length; i += 2) {
      List<Widget> rowButtons = [];

      for (int j = i; j < i + 2 && j < categories.length; j++) {
        rowButtons.add(Expanded(child: buildCategoryButton(categories[j])));
      }
      buttons.add(Row(children: rowButtons));
    }
    return buttons;
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Favorites'),
      ),
      body: Column(
        children: [
          Wrap(
            children: buildCategoryButtons(),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: filteredQuotes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    filteredQuotes[index].text,
                    style: const TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 20.0, // Adjust font size as needed
                      ),
                    ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: FavoriteIcon(isLiked: quotesLiked.contains(filteredQuotes[index].id)),
                        onPressed: () {
                          setState(() {
                            // toggleLike(index);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Share.share(filteredQuotes[index].text);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: const LeftMenu(),
    );
  }
}