import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/custom_button.dart';

import 'login_viewmodel.dart';
import 'package:food_delivery_app/ui/common/app_colors.dart';
import 'package:food_delivery_app/ui/common/app_typography.dart';

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
                style: AppTypography.h1,
              ),
              8.verticalSpace,
              Text(
                'Sign in to order your favorite meals',
                textAlign: TextAlign.center,
                style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary),
              ),
              if (viewModel.hasError) ...[
                16.verticalSpace,
                Text(
                  viewModel.modelError.toString(),
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium.copyWith(color: AppColors.error),
                ),
              ],
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