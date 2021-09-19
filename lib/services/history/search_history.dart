import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SearchHistory {
  const SearchHistory();

  static Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList('search_history') ?? [];
    print('got this : $history');
    return history;
  }

  static void saveSearchHistory(String query) async {
    print(query);
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('search_history') ?? [];
    history.removeWhere((element) => element == query);
    history.add(query);
    print('added this : $history');
    prefs.setStringList('search_history', history);
  }

  static void clearSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('search_history');
  }
}
