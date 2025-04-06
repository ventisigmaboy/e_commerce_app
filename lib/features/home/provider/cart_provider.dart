import 'package:e_commerce_app/features/models/product_res_model.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final ProductResModel product;
  final String selectedSize;
  int quantity;

  CartItem({
    required this.product,
    required this.selectedSize,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;
  bool get isEmpty => _items.isEmpty;

  void addToCart(ProductResModel product, String selectedSize) {
    final index = _items.indexWhere(
      (item) => 
          item.product.id == product.id && 
          item.selectedSize == selectedSize,
    );

    if (index != -1) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(
        product: product,
        selectedSize: selectedSize,
      ));
    }
    notifyListeners();
  }

  double get subTotal {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  void incrementQty(int index) {
    _items[index].quantity += 1;
    notifyListeners();
  }

  void decrementQty(int index) {
    if (_items[index].quantity > 1) {
      _items[index].quantity -= 1;
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