import 'dart:convert';
import 'package:http/http.dart' as http;
import 'modelClass.dart'; // Import your Product and Vendor model

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/products'; // Change to your FastAPI server URL

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // Parse the JSON response and return a list of Product objects
      final List<dynamic> jsonResponse = json.decode(response.body);
      // Log the response for debugging
      print('Fetched products: $jsonResponse');
      return jsonResponse.map((json) {
        return Product.fromJson(json);
      }).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> fetchProductsByCategory(int categoryId) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/products?category_id=$categoryId'));

    if (response.statusCode == 200) {
      // Log the response for debugging
      print('Fetched products by category: ${response.body}');
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) {
        // Log each product being parsed
        print('Parsing product: $product');
        return Product.fromJson(product);
      }).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
