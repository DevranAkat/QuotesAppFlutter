import 'package:shared_preferences/shared_preferences.dart';

class LikedQuotesManager {
    static const String _kLikedQuotesKey = 'likedQuotes';

    // Function to save the liked quotes
    static Future<void> saveLikedQuotes(List<String> likedQuotes) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_kLikedQuotesKey, likedQuotes);
    }

    // Function to retrieve the liked quotes
    static Future<List<String>> getLikedQuotes() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_kLikedQuotesKey) ?? [];
    }
  }