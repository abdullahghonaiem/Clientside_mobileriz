// import 'package:flutter/material.dart'; // Import Flutter Material package
// import 'package:mobileriz/modelClass.dart'; // Import your Product class from one location
// import 'cart_model.dart'; // Import CartModel
// import 'package:provider/provider.dart'; // Import Provider package
//
//
// class CartProvider with ChangeNotifier {
//   final CartModel _cartModel = CartModel();
//
//   List<Product> get items => _cartModel.items;
//
//   void addProduct(Product product) {
//     _cartModel.addProduct(product);
//     print('Product added: ${product.name}'); // Debugging line
//     notifyListeners(); // Notify listeners to update UI
//   }
//
//
//   void removeProduct(Product product) {
//     _cartModel.removeProduct(product);
//     notifyListeners(); // Notify listeners to update UI
//   }
//
//   double get totalPrice => _cartModel.totalPrice;
//   void clearCart() {
//     _cartModel.clearItems(); // Assuming CartModel has a method to clear items
//     notifyListeners();  // Notify listeners so that the UI can update accordingly
//   }
// }
