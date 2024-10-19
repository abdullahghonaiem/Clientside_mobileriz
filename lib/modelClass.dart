
class Vendor {
  final int id;
  final String name;
  final String imageUrl;

  Vendor({required this.id, required this.name, required this.imageUrl});

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int vendorId;
  final int categoryId;
  final Vendor vendor; // This should now be recognized

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.vendorId,
    required this.categoryId,
    required this.vendor,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Handle vendor_info as a Map
    final vendorJson = json['vendor_info'] != null
        ? json['vendor_info'] as Map<String, dynamic>
        : <String, dynamic>{}; // Provide an empty map with the correct type

    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['image_url'],
      vendorId: json['vendor_id'],
      categoryId: json['category_id'],
      vendor: Vendor.fromJson(vendorJson), // This should work now
    );
  }
}
