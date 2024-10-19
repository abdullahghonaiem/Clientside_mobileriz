import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobileriz/api_service.dart'; // Import your ApiService
import 'package:mobileriz/cart_model.dart';
import 'package:mobileriz/cart_provider.dart';
import 'package:mobileriz/modelClass.dart';
import 'package:mobileriz/screens/cart.dart';
import 'package:provider/provider.dart';
import 'ProductDetailScreen.dart'; // Import your ProductDetailScreen
import 'package:badges/badges.dart' as badges;

class ProductListingScreen extends StatefulWidget {
  static const String id = 'ProductListingScreen';

  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  int activeIndex = 0;
  late Future<List<Product>> futureProducts; // Declare Future variable
  final ApiService apiService =
      ApiService(); // Create an instance of ApiService
  List<Product> allProducts = []; // Store all products
  List<Product> filteredProducts = []; // Store filtered products
  String searchQuery = ''; // Store the search query

  @override
  void initState() {
    super.initState();
    futureProducts = apiService.fetchProducts(); // Fetch products on init
  }

  // Reusable Category row
  Widget buildCategoryItem(String imagePath, String label, int categoryId) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              futureProducts = apiService.fetchProductsByCategory(categoryId);
            });
          },
          icon: Image.asset(
            'images/$imagePath',
            width: 40,
            height: 40,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0XFF939393),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // Reusable Product card
  Widget buildProductCard(Product product) {
    return Card(
      color: const Color(0XFFFAFAFC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      elevation: 0.5,
      child: InkWell(
        onTap: () {
          // Navigate to ProductDetailScreen when the product is tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetailScreen(product: product), // Pass the product
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  product.imageUrl ?? '', // Handle empty URL
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    product.name ?? 'Unknown',
                    style: GoogleFonts.inter(
                      color: const Color(0XFF393F42),
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\₺${product.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 144,
                    height: 31,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<CartModel>(context, listen: false)
                            .addProduct(
                                product); // This should call the add method
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF67c4a7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text('Add to cart',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to filter products based on search query
  void filterProducts(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredProducts = allProducts.where((product) {
        final productName = product.name?.toLowerCase() ?? '';
        return productName.contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context); // Access the provider

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
            child: Column(
              children: [
                // Address and icons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery address',
                          style: GoogleFonts.inter(
                            color: const Color(0XFFC8C8CB),
                            fontSize: 10,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Izmir, Barnova, Turkey',
                              style: GoogleFonts.inter(
                                color: const Color(0XFF393F42),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Image.asset(
                              'images/arrowDown.png',
                              width: 12,
                              height: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Consumer<CartModel>(
                          builder: (context, cartModel, child) {
                            return badges.Badge(
                              badgeContent: Text(
                                cartModel.itemCount.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              badgeStyle: const badges.BadgeStyle(
                                  badgeColor: Color(0XFFD65B5B)),
                              position:
                                  badges.BadgePosition.topEnd(top: 0, end: 2),
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
                  ],
                ),
                const SizedBox(height: 20),

                // Search bar
                TextField(
                  onChanged: filterProducts,
                  // Call filter function on text change
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    hintText: "Search here ...",
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0XFFC8C8CB),
                      fontSize: 13,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'images/search.png',
                        width: 16,
                        height: 16,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFFF0F2F1),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFFF0F2F1),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Carousel Slider
                CarouselSlider(
                  options: CarouselOptions(
                    height: 160.0,
                    autoPlay: true,
                    viewportFraction: 0.85,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index),
                    autoPlayInterval: const Duration(seconds: 3),
                    enlargeCenterPage: false,
                  ),
                  items: [
                    'baner1.png',
                    'baner2.png',
                    'baner3.png',
                  ].map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: 324.0,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: AssetImage('images/$imagePath'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),

                Row(children: [
                  Text(
                    'Category',
                    style: GoogleFonts.inter(
                      color: const Color(0XFF393F42),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildCategoryItem('apparel.png', 'Apparel', 1),
                    buildCategoryItem('school.png', 'School', 2),
                    buildCategoryItem('sports.png', 'sports', 3),
                    buildCategoryItem('electronics.png', 'electronics', 4),
                  ],
                ),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent products',
                      style: GoogleFonts.inter(
                        color: const Color(0XFF393F42),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        width: 78,
                        height: 27,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), // Set the border radius to 8
                          border: Border.all(
                            color: Color(0XFFF0F2F1), // Border color
                            width: 1.0, // Border width
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Filters',
                              style: GoogleFonts.inter(
                                color: const Color(0XFF393F42),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Image.asset(
                              'images/filter.png',
                              width: 12,
                              height: 12,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),

                FutureBuilder<List<Product>>(
                  future: futureProducts,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      allProducts = snapshot.data ?? [];
                      filteredProducts = allProducts
                          .where((product) =>
                              product.name!.toLowerCase().contains(searchQuery))
                          .toList();
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16.0,
                          crossAxisSpacing: 16.0,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return buildProductCard(filteredProducts[index]);
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
