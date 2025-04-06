import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  bool get isEmpty => _items.isEmpty;

  void addToCart(Map<String, dynamic> product, String selectedSize) {
    final index = _items.indexWhere(
      (item) =>
          item['id'] == product['id'] && item['selectedSize'] == selectedSize,
    );

    if (index != -1) {
      _items[index]['quantity'] += 1;
    } else {
      _items.add({
        'id': product['id'],
        'title': product['title'],
        'image': product['image'],
        'price': product['price'],
        'selectedSize': selectedSize,
        'quantity': 1,
      });
    }
    notifyListeners();
  }

  double get subTotal {
    return _items.fold(0.0, (sum, item) {
      return sum + (item['price'] * item['quantity']);
    });
  }

  void incrementQty(int index) {
    _items[index]['quantity'] += 1;
    notifyListeners();
  }

  void decrementQty(int index) {
    if (_items[index]['quantity'] > 1) {
      _items[index]['quantity'] -= 1;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
