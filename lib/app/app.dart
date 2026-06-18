import 'package:food_delivery_app/services/auth_service.dart';
import 'package:food_delivery_app/services/firestore_service.dart';
import 'package:food_delivery_app/services/product_service.dart';
import 'package:food_delivery_app/services/cart_service.dart';
import 'package:food_delivery_app/services/order_service.dart';
import 'package:food_delivery_app/ui/views/home/homeview.dart';
import 'package:food_delivery_app/ui/views/login/loginview.dart';
import 'package:food_delivery_app/ui/views/startup/startupview.dart';
import 'package:food_delivery_app/ui/views/cart/cart_view.dart';
import 'package:food_delivery_app/ui/views/orders/orders_view.dart';
import 'package:food_delivery_app/ui/views/order_tracking/order_tracking_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(
      page: StartupView,
      initial: true,
    ),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: CartView),
    MaterialRoute(page: OrdersView),
    MaterialRoute(page: OrderTrackingView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: FirestoreService),
    LazySingleton(classType: ProductService),
    LazySingleton(classType: CartService),
    LazySingleton(classType: OrderService),
  ],
)
class App {}

