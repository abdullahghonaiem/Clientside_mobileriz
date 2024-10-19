import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileriz/cart_model.dart';
import 'package:mobileriz/modelClass.dart';
import 'package:provider/provider.dart';
import 'package:mobileriz/cart_provider.dart'; // Import CartProvider
import 'package:mobileriz/widgets/CartItem.dart'; // Import CartItem
import 'package:badges/badges.dart' as badges;

class Cart extends StatelessWidget {
  static const String id = 'Cart';

  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the cart items from CartProvider
    final cartProvider = Provider.of<CartModel>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      'images/backArrow.png',
                      width: 28,
                      height: 28,
                    ),
                  ),
                  Text(
                    'Your Cart',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0XFF393F42),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Consumer<CartModel>(
                    builder: (context, cartModel, child) {
                      return badges.Badge(
                        badgeContent: Text(
                          cartModel.itemCount.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        badgeStyle: const badges.BadgeStyle(badgeColor: Color(0XFFD65B5B)),
                        position: badges.BadgePosition.topEnd(top: 0, end: 2),
                        child: IconButton(
                          onPressed: () {
                          },
                          icon: Image.asset(
                            'images/cart.png',
                            width: 28,
                            height: 28,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Color(0XFFD9D9D9),
            ),
            // Display cart items dynamically
            if (cartProvider.items.isEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'Your cart is empty',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: const Color(0XFF393F42),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final product = cartProvider.items[index];
                    return CartItem(
                      imageUrl: product.imageUrl, // Assuming Product has imageUrl
                      productName: product.name,    // Assuming Product has name
                      price: '\₺ ${product.price.toStringAsFixed(2)}', // Assuming Product has price
                      onRemove: () {
                        // // Implement the logic to remove the product from the cart
                        cartProvider.removeProduct(product);
                      },
                    );
                  },
                ),
              ),

            const Divider(
              thickness: 1,
              color: Color(0XFFD9D9D9),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '\₺ ${cartProvider.totalPrice.toStringAsFixed(2)}', // Use totalPrice from CartProvider
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                width: 300,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    // Trigger the confirmation dialog on checkout button press
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Color(0xFF67c4a7),
                                  size: 80,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Congrats! your payment is successfully',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Track your order or just chat directly to the seller. Download order summary in down below',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Color(0xFF393F42),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.file_download_outlined, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'order_invoice',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    // Clear the cart after successful payment
                                    cartProvider.clearItems();
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF67c4a7),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: Text(
                                    'Continue',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF67c4a7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Checkout',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
