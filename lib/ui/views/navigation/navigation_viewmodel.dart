import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../models/notification_model.dart';
import '../../../services/notification_service.dart';
import '../../../services/auth_service.dart';
import '../../../services/cart_service.dart';

class NavigationViewModel extends IndexTrackingViewModel {
  final _notificationService = locator<NotificationService>();
  final _authService = locator<AuthService>();
  final _cartService = locator<CartService>();

  int _unreadCount = 0;
  int get unreadCount => _unreadCount;

  int get cartCount => _cartService.totalItems;

  NavigationViewModel() {
    _listenToNotifications();
    _cartService.cartItems.addListener(notifyListeners);
  }

  void _listenToNotifications() {
    final user = _authService.currentUser;
    if (user != null) {
      _notificationService.getUserNotifications(user.uid).listen((notifications) {
        _unreadCount = notifications.where((n) => !n.isRead).length;
        notifyListeners();
      });
    }
  }

  @override
  void dispose() {
    _cartService.cartItems.removeListener(notifyListeners);
    super.dispose();
  }
}

