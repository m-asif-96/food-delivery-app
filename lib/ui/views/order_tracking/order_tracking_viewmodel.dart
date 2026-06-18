import 'dart:async';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../models/order_model.dart';
import '../../../services/order_service.dart';
import '../../../services/notification_service.dart';

class OrderTrackingViewModel extends StreamViewModel<OrderModel> {
  final String orderId;
  final _orderService = locator<OrderService>();
  final _notificationService = locator<NotificationService>();
  Timer? _mockTimer;

  OrderTrackingViewModel({required this.orderId});

  @override
  Stream<OrderModel> get stream => _orderService.getOrder(orderId);

  @override
  void onData(OrderModel? data) {
    super.onData(data);
    _handleMockStatusUpdates(data?.status, data?.userId);
  }

  void _handleMockStatusUpdates(String? currentStatus, String? userId) {
    _mockTimer?.cancel();
    if (userId == null) return;

    if (currentStatus == 'Pending') {
      _mockTimer = Timer(const Duration(seconds: 10), () {
        _orderService.updateOrderStatus(orderId, 'Preparing');
        _notificationService.sendNotification(
          userId: userId,
          title: 'Order Preparing 🍳',
          message: 'Your order #${orderId.substring(0, 8)} is now being prepared.',
        );
      });
    } else if (currentStatus == 'Preparing') {
      _mockTimer = Timer(const Duration(seconds: 10), () {
        _orderService.updateOrderStatus(orderId, 'Out for Delivery');
        _notificationService.sendNotification(
          userId: userId,
          title: 'Out for Delivery 🛵',
          message: 'Your order #${orderId.substring(0, 8)} is on its way!',
        );
      });
    } else if (currentStatus == 'Out for Delivery') {
      _mockTimer = Timer(const Duration(seconds: 10), () {
        _orderService.updateOrderStatus(orderId, 'Delivered');
        _notificationService.sendNotification(
          userId: userId,
          title: 'Delivered 🎉',
          message: 'Enjoy your food! Your order #${orderId.substring(0, 8)} has arrived.',
        );
      });
    }
  }

  @override
  void dispose() {
    _mockTimer?.cancel();
    super.dispose();
  }
}
