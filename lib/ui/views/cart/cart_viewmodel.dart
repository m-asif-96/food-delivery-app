import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/cart_item_model.dart';
import '../../../models/product_model.dart';
import '../../../services/cart_service.dart';
import '../../../services/auth_service.dart';
import '../../../services/order_service.dart';
import '../../../services/stripe_service.dart';

class CartViewModel extends BaseViewModel {
  final _cartService = locator<CartService>();
  final _authService = locator<AuthService>();
  final _orderService = locator<OrderService>();
  final _stripeService = locator<StripeService>();
  final _navigationService = locator<NavigationService>();

  List<CartItem> get cartItems => _cartService.cartItems.value;
  double get totalPrice => _cartService.totalPrice;

  CartViewModel() {
    _cartService.cartItems.addListener(_onCartChanged);
  }

  void _onCartChanged() {
    notifyListeners();
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
    clearErrors();

    try {
      // 1. Process Stripe Payment
      final paymentSuccess = await _stripeService.processPayment(totalPrice);

      if (!paymentSuccess) {
        setError('Payment failed or was canceled.');
        setBusy(false);
        return;
      }

      // 2. If payment succeeds, create the order
      final orderId = await _orderService.createOrder(
        userId: user.uid,
        items: cartItems,
        totalAmount: totalPrice,
      );

      // 3. Clear the cart
      _cartService.clearCart();
      
      // 4. Navigate to order tracking
      _navigationService.navigateTo(
        Routes.orderTrackingView,
        arguments: OrderTrackingViewArguments(orderId: orderId),
      );
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    _cartService.cartItems.removeListener(_onCartChanged);
    super.dispose();
  }
}
