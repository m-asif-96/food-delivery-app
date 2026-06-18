import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../models/order_model.dart';
import '../../../services/order_service.dart';
import '../../../services/auth_service.dart';

class OrdersViewModel extends StreamViewModel<List<OrderModel>> {
  final  OrderService _orderService = locator<OrderService>();
  final  AuthService _authService = locator<AuthService>();

  @override
  Stream<List<OrderModel>> get stream {
    final user = _authService.currentUser;
    if (user == null) return const Stream.empty();
    return _orderService.getUserOrders(user.uid);
  }
}
