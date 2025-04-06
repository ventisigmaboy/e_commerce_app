import 'package:e_commerce_app/features/models/product_res_model.dart';
import 'package:flutter/foundation.dart';

class FavoritesService with ChangeNotifier {
  final List<ProductResModel> _favoriteItems = [];

  List<ProductResModel> get favorites => _favoriteItems;

  void addToFavorites(ProductResModel product) {
    if (!_favoriteItems.any((item) => item.id == product.id)) {
      _favoriteItems.add(product);
      notifyListeners();
    }
  }

  void removeFromFavorites(ProductResModel product) {
    _favoriteItems.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }

  bool isFavorite(ProductResModel product) {
    return _favoriteItems.any((item) => item.id == product.id);
  }
}