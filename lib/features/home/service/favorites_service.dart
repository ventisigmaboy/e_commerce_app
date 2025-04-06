// lib/features/favorites/service/favorites_service.dart
import 'package:flutter/foundation.dart';

class FavoritesService with ChangeNotifier {
  final List<dynamic> _favoriteItems = [];

  List<dynamic> get favorites => _favoriteItems;

  void addToFavorites(dynamic product) {
    if (!_favoriteItems.any((item) => item['id'] == product['id'])) {
      _favoriteItems.add(product);
      notifyListeners();
    }
  }

  void removeFromFavorites(dynamic product) {
    _favoriteItems.removeWhere((item) => item['id'] == product['id']);
    notifyListeners();
  }

  bool isFavorite(dynamic product) {
    return _favoriteItems.any((item) => item['id'] == product['id']);
  }
}