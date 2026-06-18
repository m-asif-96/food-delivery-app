import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../models/notification_model.dart';
import '../../../services/notification_service.dart';
import '../../../services/auth_service.dart';

class NavigationViewModel extends IndexTrackingViewModel {
  final _notificationService = locator<NotificationService>();
  final _authService = locator<AuthService>();

  int _unreadCount = 0;
  int get unreadCount => _unreadCount;

  NavigationViewModel() {
    _listenToNotifications();
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
}

