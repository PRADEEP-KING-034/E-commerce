import 'package:e_commerce/repo/product_repository.dart';
import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ProductDetailsViewModel extends ChangeNotifier {
  final ProductRepository repository;
  ProductDetailsViewModel({required this.repository});

  Product? product;
  bool isLoading = false;
  String? error;

  Future<void> loadProduct(int id) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      product = await repository.fetchProductById(id);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
