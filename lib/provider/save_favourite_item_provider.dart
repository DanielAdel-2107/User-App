import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteProvider with ChangeNotifier {
  Map<int, bool> _favouriteMap = {};

  FavouriteProvider() {
    _loadFavourites();
  }

  void _loadFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Load favourite status for each item
    // for (int key in prefs.getKeys()) {
    //   _favouriteMap[int.parse(key)] = prefs.getBool(key) ?? false;
    // }
    notifyListeners();
  }

  void _saveFavourite(int itemId, bool isFavourite) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(itemId.toString(), isFavourite);
  }

  bool? isItemFavourite(int itemId) {
    return _favouriteMap.containsKey(itemId) ? _favouriteMap[itemId] : false;
  }

  void toggleFavourite(int itemId) {
    if (_favouriteMap.containsKey(itemId)) {
      _favouriteMap[itemId] = !_favouriteMap[itemId]!;
    } else {
      _favouriteMap[itemId] = true;
    }
    _saveFavourite(itemId, _favouriteMap[itemId]!);
    notifyListeners();
  }
}