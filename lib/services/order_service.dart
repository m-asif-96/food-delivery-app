import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';
import '../models/cart_item_model.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createOrder({
    required String userId,
    required List<CartItem> items,
    required double totalAmount,
  }) async {
    try {
      final docRef = await _firestore.collection('orders').add({
        'userId': userId,
        'items': items.map((item) => {
          'product': item.product.toMap()..addAll({'id': item.product.id}),
          'quantity': item.quantity,
        }).toList(),
        'totalAmount': totalAmount,
        'status': 'Pending',
        'createdAt': FieldValue.serverTimestamp(),
      });
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  Stream<List<OrderModel>> getUserOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          final orders = snapshot.docs
              .map((doc) => OrderModel.fromMap(doc.data(), doc.id))
              .toList();
          
          orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return orders;
        });
  }

  Stream<OrderModel> getOrder(String orderId) {
    return _firestore.collection('orders').doc(orderId).snapshots().map(
      (doc) {
        if (!doc.exists) throw Exception('Order not found');
        return OrderModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      },
    );
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': newStatus,
    });
  }
}
