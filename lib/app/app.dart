import 'package:food_delivery_app/services/auth_service.dart';
import 'package:food_delivery_app/services/firestore_service.dart';
import 'package:food_delivery_app/services/product_service.dart';
import 'package:food_delivery_app/services/cart_service.dart';
import 'package:food_delivery_app/ui/views/home/homeview.dart';
import 'package:food_delivery_app/ui/views/login/loginview.dart';
import 'package:food_delivery_app/ui/views/startup/startupview.dart';
import 'package:food_delivery_app/ui/views/cart/cart_view.dart';
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
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: FirestoreService),
    LazySingleton(classType: ProductService),
    LazySingleton(classType: CartService),
  ],
)
class App {}
