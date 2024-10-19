import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileriz/cart_model.dart';
import 'package:mobileriz/cart_provider.dart';
import 'package:mobileriz/modelClass.dart';
import 'package:mobileriz/screens/cart.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetailScreen extends StatelessWidget {
  static const String id = 'ProductDetailScreen';

  final Product product; // Accepting the product object

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
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
                      'Product details',
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
                              Navigator.pushNamed(context, Cart.id);
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
              // Use the product's image here
              Image.network(
                product.imageUrl,
                // Directly use imageUrl, no need for null check as Product fields are required
                width: double.infinity,
                height: 286,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 100);
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display the product name
                    Text(
                      product.name, // Directly use name, no need for null check
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Display the product price
                    Text(
                      '\₺${product.price.toStringAsFixed(2)}',
                      // Directly use price, no need for null check
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.green),
                    ),
                    Center(
                      child: Text(
                        '(219 People buy this)',
                        // Placeholder text, replace with real data if available
                        style: GoogleFonts.inter(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                color: Color(0XFFD9D9D9),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                ),
                child: Row(
                  children: [
                    // Display vendor image
                    ClipOval(
                      child: Image.network(
                        product.vendor.imageUrl,
                        width: 49,
                        height: 49,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      product.vendor.name,
                      // This should display the vendor's name
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 107,
                        height: 37,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // Optional: Set a background color
                          border: Border.all(
                            color: Color(0XFFD9D9D9),
                            // Set the border color to yellow
                            width:
                                2.0, // Set the border width (adjust as needed)
                          ),
                          borderRadius:
                              BorderRadius.circular(4), // Set the border radius
                        ),
                        child: Center(
                          child: Text(
                            'Follow',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                color: Color(0XFFD9D9D9),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description of product',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Display the product description
                    Text(
                      product.description,
                      // Directly use description, no need for null check
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0XFF393F42),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Container(
                        child: SizedBox(
                          width: 261,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Provider.of<CartModel>(context, listen: false)
                                  .addProduct(product);
                              // Optionally show a snackbar
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0XFF67c4a7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Text(
                              'Add to cart',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
