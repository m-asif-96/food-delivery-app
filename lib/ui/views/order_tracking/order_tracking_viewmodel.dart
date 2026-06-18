import 'dart:async';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../models/order_model.dart';
import '../../../services/order_service.dart';

class OrderTrackingViewModel extends StreamViewModel<OrderModel> {
  final String orderId;
  final  OrderService _orderService = locator<OrderService>();
  Timer? _mockTimer;

  OrderTrackingViewModel({required this.orderId});

  @override
  Stream<OrderModel> get stream => _orderService.getOrder(orderId);

  @override
  void onData(OrderModel? data) {
    super.onData(data);
    _handleMockStatusUpdates(data?.status);
  }

  void _handleMockStatusUpdates(String? currentStatus) {
    _mockTimer?.cancel();

    if (currentStatus == 'Pending') {
      _mockTimer = Timer(const Duration(seconds: 10), () {
        _orderService.updateOrderStatus(orderId, 'Preparing');
      });
    } else if (currentStatus == 'Preparing') {
      _mockTimer = Timer(const Duration(seconds: 10), () {
        _orderService.updateOrderStatus(orderId, 'Out for Delivery');
      });
    } else if (currentStatus == 'Out for Delivery') {
      _mockTimer = Timer(const Duration(seconds: 10), () {
        _orderService.updateOrderStatus(orderId, 'Delivered');
      });
    }
  }

  @override
  void dispose() {
    _mockTimer?.cancel();
    super.dispose();
  }
}
