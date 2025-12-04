import 'package:e_commerce/repo/product_repository.dart';
import 'package:flutter/foundation.dart';
import '../models/product.dart';

enum ViewState { idle, busy, error }

class ProductListViewModel extends ChangeNotifier {
  final ProductRepository repository;
  ProductListViewModel({required this.repository});

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  List<Product> _products = [];
  List<Product> get products => _products;

  String? errorMessage;

  Future<void> loadProducts() async {
    _state = ViewState.busy;
    errorMessage = null;
    notifyListeners();
    try {
      _products = await repository.fetchAllProducts();
      _state = ViewState.idle;
    } catch (e) {
      _state = ViewState.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> refresh() async => await loadProducts();
}
