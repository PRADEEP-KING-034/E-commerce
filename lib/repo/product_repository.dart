import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductRepository {
  static const String baseUrl = 'https://fakestoreapi.com';

  final http.Client client;
  ProductRepository({http.Client? client}) : client = client ?? http.Client();

  Future<List<Product>> fetchAllProducts() async {
    final url = Uri.parse('$baseUrl/products');
    final res = await client.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as List;
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> fetchProductById(int id) async {
    final url = Uri.parse('$baseUrl/products/$id');
    final res = await client.get(url);
    if (res.statusCode == 200) {
      return Product.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<List<String>> fetchCategories() async {
    final url = Uri.parse('$baseUrl/products/categories');
    final res = await client.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as List;
      return data.map((e) => e.toString()).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Product>> fetchProductsByCategory(String category) async {
    final url = Uri.parse('$baseUrl/products/category/$category');
    final res = await client.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as List;
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load category products');
    }
  }
}
