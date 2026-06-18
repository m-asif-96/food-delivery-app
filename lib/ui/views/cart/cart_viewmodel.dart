import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../models/cart_item_model.dart';
import '../../../models/product_model.dart';
import '../../../services/cart_service.dart';

class CartViewModel extends BaseViewModel {
  final _cartService = locator<CartService>();

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
}
