// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:mobileriz/api_service.dart'; // Import your ApiService
// import 'package:mobileriz/modelClass.dart';
// import 'ProductDetailScreen.dart'; // Import your ProductDetailScreen
//
// class ProductListingScreen extends StatefulWidget {
//   static const String id = 'ProductListingScreen';
//
//   const ProductListingScreen({super.key});
//
//   @override
//   State<ProductListingScreen> createState() => _ProductListingScreenState();
// }
//
// class _ProductListingScreenState extends State<ProductListingScreen> {
//   int activeIndex = 0;
//   late Future<List<Product>> futureProducts; // Declare Future variable
//   final ApiService apiService = ApiService(); // Create an instance of ApiService
//   List<Product> allProducts = []; // Store all products
//   List<Product> filteredProducts = []; // Store filtered products
//   String searchQuery = ''; // Store the search query
//
//   @override
//   void initState() {
//     super.initState();
//     futureProducts = apiService.fetchProducts(); // Fetch products on init
//   }
//
//   // Reusable Category row
//   Widget buildCategoryItem(String imagePath, String label, int categoryId) {
//     return Column(
//       children: [
//         IconButton(
//           onPressed: () {
//             setState(() {
//               futureProducts = apiService.fetchProductsByCategory(categoryId);
//             });
//           },
//           icon: Image.asset(
//             'images/$imagePath',
//             width: 40,
//             height: 40,
//           ),
//         ),
//         Text(
//           label,
//           style: GoogleFonts.inter(
//             color: const Color(0XFF939393),
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }