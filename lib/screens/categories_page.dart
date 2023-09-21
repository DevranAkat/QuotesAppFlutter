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
  late String selectedCategory;
  List<Quote> filteredQuotes = [];
  List<String> quotesLiked = [];
  List<String> categories = quotes.map((quote) => quote.category).toSet().toList();
  
  @override
  void initState() {
    super.initState();
    sortCategories();
    filterQuotesByCategory('');
    getLikedQuotesList();
  }

  void sortCategories() => categories.sort();
  
  void filterQuotesByCategory(String category) {
    setState(() {
      selectedCategory = category == '' ? categories[0] : category;
      filteredQuotes = quotes.where((quote) => quote.category == selectedCategory).toList();
    });
  }

  void getLikedQuotesList() async{
    final SharedPreferences prefs = await _prefs;
    setState(() {
      quotesLiked = prefs.getStringList("likedQuotes") ?? [];
    });
  }

  Widget buildCategoryDropdown() {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButton<String>(
          value: selectedCategory,
          dropdownColor: Colors.black87,
          onChanged: (newValue) {
            setState(() {
              selectedCategory = newValue!;
              filterQuotesByCategory(newValue);
            });
          },
          items: categories
            .map((category) => DropdownMenuItem<String>(
              value: category,
              child: Text(
                category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ))
            .toList(),
        ),
      ),
    );
  }

  Future<void> toggleLike(id) async {
    final SharedPreferences prefs = await _prefs;
    quotesLiked.contains(id.toString()) ? quotesLiked.remove(id.toString()) : quotesLiked.add(id.toString());
    prefs.setStringList("likedQuotes", quotesLiked);

    setState(() {
      quotes.firstWhere((element) => element.id == id).liked = quotesLiked.contains(id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Categories'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: buildCategoryDropdown(),
              ),
            ],
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
                        icon: FavoriteIcon(isLiked: filteredQuotes[index].liked),
                        onPressed: () {
                          setState(() {
                            toggleLike(filteredQuotes[index].id);
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