import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/models/model_product.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  List<Product> _posters = [];
  List<Product> get posters => _posters;

  UiState _uiState = UiState.loading;
  UiState get uiState => _uiState;

  Future<void> fetchProducts(String category) async {
    _uiState = UiState.loading;
    notifyListeners();
    final url = 'https://dummyjson.com/products/category/$category';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['products'] as List;
        _products = jsonData.map((json) => Product.fromJson(json)).toList();
        _uiState = UiState.loaded;
      } else {
        _uiState = UiState.error;
      }
    } catch (e) {
      _uiState = UiState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchPoster() async {
    _uiState = UiState.loading;
    notifyListeners();
    final url = 'https://dummyjson.com/products?limit=10';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['products'] as List;
        _posters = jsonData.map((json) => Product.fromJson(json)).toList();
        _uiState = UiState.loaded;
      } else {
        _uiState = UiState.error;
      }
    } catch (e) {
      _uiState = UiState.error;
    } finally {
      notifyListeners();
    }
  }
}

enum UiState { loading, loaded, error }
