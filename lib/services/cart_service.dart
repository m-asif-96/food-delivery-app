import 'package:flutter/foundation.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartService {
  final ValueNotifier<List<CartItem>> cartItems = ValueNotifier([]);

  void addToCart(Product product) {
    final index = cartItems.value.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      cartItems.value[index].quantity++;
      cartItems.notifyListeners();
    } else {
      cartItems.value.add(CartItem(product: product));
      cartItems.notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    cartItems.value.removeWhere((item) => item.product.id == product.id);
    cartItems.notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      removeFromCart(product);
      return;
    }
    final index = cartItems.value.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      cartItems.value[index].quantity = quantity;
      cartItems.notifyListeners();
    }
  }

  double get totalPrice {
    return cartItems.value.fold(0, (total, item) => total + item.totalPrice);
  }

  int get totalItems {
    return cartItems.value.fold(0, (total, item) => total + item.quantity);
  }
  
  void clearCart() {
    cartItems.value.clear();
    cartItems.notifyListeners();
  }
}
