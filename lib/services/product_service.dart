import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Product> _cachedProducts = [];

  bool get hasCachedProducts => _cachedProducts.isNotEmpty;

  Future<List<Product>> getProducts({bool forceRefresh = false}) async {
    if (_cachedProducts.isNotEmpty && !forceRefresh) {
      return _cachedProducts;
    }
    try {
      final snapshot = await _firestore.collection('products').get();
      _cachedProducts = snapshot.docs.map((doc) => Product.fromMap(doc.data(), doc.id)).toList();
      return _cachedProducts;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
}
