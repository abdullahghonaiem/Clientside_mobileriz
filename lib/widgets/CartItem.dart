import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileriz/modelClass.dart'; // Adjust the import according to your actual file structure

class CartItem extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String price;
  final VoidCallback onRemove; // Callback for removing the item

  const CartItem({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.onRemove, // Accept the remove callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: Row(
        children: [
          Image.network(
            imageUrl,
            width: 90,
            height: 90,
          ),
          // Keep your image URL for the product
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: GoogleFonts.inter(
                    color: const Color(0XFF393F42),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 5, // Adjust the number of lines as needed
                  overflow: TextOverflow
                      .ellipsis, // Optionally, add ellipsis if the text overflows
                ),
                Text(
                  price,
                  style: GoogleFonts.inter(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onRemove,
            iconSize: 20,
          ),
        ],
      ),
    );
  }
}
