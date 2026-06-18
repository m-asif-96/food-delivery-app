class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  /// A smaller, optimized version of [imageUrl] for use in lists and grids.
  /// Falls back to [imageUrl] if not available.
  /// Generate thumbnails via Firebase Extensions > Resize Images.
  final String thumbnailUrl;

  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    String? thumbnailUrl,
    required this.category,
  }) : thumbnailUrl = thumbnailUrl?.isNotEmpty == true ? thumbnailUrl! : imageUrl;

  factory Product.fromMap(Map<String, dynamic> map, String documentId) {
    return Product(
      id: documentId,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      thumbnailUrl: map['thumbnailUrl'] ?? '',
      category: map['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'thumbnailUrl': thumbnailUrl,
      'category': category,
    };
  }
}
