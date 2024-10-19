import 'package:flutter/material.dart';
import 'package:mobileriz/cart_model.dart';
import 'package:mobileriz/cart_provider.dart';
import 'package:mobileriz/productProvider.dart';
import 'package:mobileriz/screens/cart.dart';
import 'package:mobileriz/screens/productDetailScreen.dart';
import 'package:mobileriz/screens/productListingScreen.dart';
import 'package:mobileriz/screens/splashScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: Mobileriz(),
    ),
  );
}

class Mobileriz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Splash_Screen.id,
      routes: {
        ProductListingScreen.id: (context) => ProductListingScreen(),
        Splash_Screen.id: (context) => Splash_Screen(),
        Cart.id: (context) => const Cart(),
        // ProductDetailScreen.id: (context) => const ProductDetailScreen(product: null,), // Make sure this is uncommented
      },
    );
  }
}
