import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../models/notification_model.dart';
import '../../../services/notification_service.dart';
import '../../../services/auth_service.dart';

class NotificationsViewModel extends StreamViewModel<List<NotificationModel>> {
  final _notificationService = locator<NotificationService>();
  final _authService = locator<AuthService>();

  @override
  Stream<List<NotificationModel>> get stream {
    final user = _authService.currentUser;
    if (user == null) return const Stream.empty();
    return _notificationService.getUserNotifications(user.uid);
  }

  void markAsRead(String notificationId) {
    _notificationService.markAsRead(notificationId);
  }
}

