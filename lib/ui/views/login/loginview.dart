import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/custom_button.dart';

import 'login_viewmodel.dart';
import 'package:food_delivery_app/ui/common/app_colors.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(
                Icons.fastfood,
                size: 100.w,
                color: AppColors.primary,
              ),
              32.verticalSpace,
              Text(
                'Welcome',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              8.verticalSpace,
              Text(
                'Sign in to order your favorite meals',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              CustomButton(
                title: 'Continue with Google',
                onPressed: viewModel.signInWithGoogle,
                isBusy: viewModel.isBusy,
                backgroundColor: AppColors.textPrimary,
                foregroundColor: AppColors.white,
                icon: Icons.login,
              ),
              48.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) =>
      LoginViewModel();
}