import 'package:flutter/material.dart';
import 'package:mobileriz/api_service.dart'; // Import your ApiService
import 'package:mobileriz/modelClass.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String _errorMessage = '';
  List<Product> _filteredProducts = [];

  List<Product> get products => _filteredProducts.isEmpty ? _products : _filteredProducts;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  final ApiService _apiService = ApiService(); // Create an instance of ApiService

  // Fetch all products from the API
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners(); // Notify listeners of loading state change

    try {
      _products = await _apiService.fetchProducts(); // Fetch products from API
      _filteredProducts = []; // Clear any previous filtered list
      _errorMessage = ''; // Clear previous error message
    } catch (e) {
      _errorMessage = 'Failed to load products: $e';
    } finally {
      _isLoading = false; // Reset loading state
      notifyListeners(); // Notify listeners after fetching products
    }
  }

  // Search products by query
  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = [];
    } else {
      _filteredProducts = _products
          .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // Fetch products by category
  Future<void> fetchProductsByCategory(int categoryId) async {
    _isLoading = true;
    notifyListeners(); // Notify listeners of loading state change

    try {
      _products = await _apiService.fetchProductsByCategory(categoryId); // Fetch products by category from API
      _filteredProducts = []; // Clear any previous filtered list
      _errorMessage = ''; // Clear previous error message
    } catch (e) {
      _errorMessage = 'Failed to load products: $e';
    } finally {
      _isLoading = false; // Reset loading state
      notifyListeners(); // Notify listeners after fetching products
    }
  }

  // Optionally, add a method to clear products
  void clearProducts() {
    _products = [];
    notifyListeners(); // Notify listeners about the change
  }
}