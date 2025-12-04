import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartViewModel extends ChangeNotifier {
  final List<CartItem> _items = [];
  List<CartItem> get items => List.unmodifiable(_items);

  void addToCart(Product product) {
    final index = _items.indexWhere((it) => it.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _items.removeWhere((it) => it.product.id == productId);
    notifyListeners();
  }

  void increaseQuantity(int productId) {
    final idx = _items.indexWhere((it) => it.product.id == productId);
    if (idx >= 0) {
      _items[idx].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(int productId) {
    final idx = _items.indexWhere((it) => it.product.id == productId);
    if (idx >= 0) {
      if (_items[idx].quantity > 1) {
        _items[idx].quantity--;
      } else {
        _items.removeAt(idx);
      }
      notifyListeners();
    }
  }

  double get totalPrice =>
      _items.fold(0.0, (sum, it) => sum + it.totalPrice);

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
