import 'cart_item_model.dart';
import 'product_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalAmount;
  final String status;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map, String documentId) {
    var itemsList = map['items'] as List? ?? [];
    List<CartItem> cartItems = itemsList.map((itemMap) {
      return CartItem(
        product: Product.fromMap(itemMap['product'], itemMap['product']['id'] ?? ''),
        quantity: itemMap['quantity'] ?? 1,
      );
    }).toList();

    return OrderModel(
      id: documentId,
      userId: map['userId'] ?? '',
      items: cartItems,
      totalAmount: (map['totalAmount'] ?? 0.0).toDouble(),
      status: map['status'] ?? 'Pending',
      createdAt: map['createdAt'] != null ? map['createdAt'].toDate() : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items.map((item) => {
        'product': item.product.toMap()..addAll({'id': item.product.id}),
        'quantity': item.quantity,
      }).toList(),
      'totalAmount': totalAmount,
      'status': status,
      'createdAt': createdAt,
    };
  }
}
