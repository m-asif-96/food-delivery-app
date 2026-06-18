import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/cart_item_model.dart';
import '../../../models/product_model.dart';
import '../../../services/cart_service.dart';
import '../../../services/order_service.dart';
import '../../../services/auth_service.dart';

class CartViewModel extends BaseViewModel {
  final _cartService = locator<CartService>();
  final _orderService = locator<OrderService>();
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  List<CartItem> get cartItems => _cartService.cartItems.value;
  double get totalPrice => _cartService.totalPrice;

  CartViewModel() {
    _cartService.cartItems.addListener(_onCartUpdated);
  }

  void _onCartUpdated() {
    notifyListeners();
  }

  @override
  void dispose() {
    _cartService.cartItems.removeListener(_onCartUpdated);
    super.dispose();
  }

  void updateQuantity(Product product, int quantity) {
    _cartService.updateQuantity(product, quantity);
  }

  void removeFromCart(Product product) {
    _cartService.removeFromCart(product);
  }

  Future<void> checkout() async {
    final user = _authService.currentUser;
    if (user == null || cartItems.isEmpty) return;

    setBusy(true);
    try {
      final orderId = await _orderService.createOrder(
        userId: user.uid,
        items: cartItems,
        totalAmount: totalPrice,
      );
      
      _cartService.clearCart();
      _navigationService.replaceWithOrderTrackingView(orderId: orderId);
    } catch (e) {
      print('Checkout error: $e');
    }
    setBusy(false);
  }
}

