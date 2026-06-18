import 'package:food_delivery_app/app/app.locator.dart';
import 'package:food_delivery_app/app/app.router.dart';
import 'package:food_delivery_app/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> signInWithGoogle() async {
  setBusy(true);

  try {
    final result = await _authService.signInWithGoogle();

    if (result?.user != null) {
      await Future.delayed(
        const Duration(milliseconds: 300),
      );

      await _navigationService.clearStackAndShow(
        Routes.navigationView,
      );
    }
  } catch (e) {
    setError(e.toString());
  }

  setBusy(false);
}
}