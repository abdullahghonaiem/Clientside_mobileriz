import 'package:flutter/material.dart';
import 'package:mobileriz/modelClass.dart';

class CartModel extends ChangeNotifier {
  final List<Product> items = [];

  void addProduct(Product product) {
    items.add(product);
    print('Product added: ${product.name}'); // Debug print
    print('Total items in cart after adding: ${items.length}'); // Debug print
    notifyListeners(); // Notify listeners
  }

  void removeProduct(Product product) {
    items.remove(product);
    print('Product removed: ${product.name}'); // Debug print
    print('Total items in cart after removing: ${items.length}'); // Debug print
    notifyListeners(); // Notify listeners
  }

  double get totalPrice {
    return items.fold(0, (total, current) => total + (current.price ?? 0));
  }

  void clearItems() {
    items.clear();
    print('Cart cleared'); // Debug print
    notifyListeners(); // Notify listeners
  }

  int get itemCount {
    return items.length;
  }
}
