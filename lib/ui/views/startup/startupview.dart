import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/loading_indicator.dart';

import 'startup_viewmodel.dart';
import 'package:food_delivery_app/ui/common/app_colors.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

  @override
  void onViewModelReady(StartupViewModel viewModel) {
    viewModel.runStartupLogic();
  }

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 80.w,
              color: AppColors.primary,
            ),
            16.verticalSpace,
            Text(
              'Food Delivery',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            48.verticalSpace,
            const LoadingIndicator(),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) =>
      StartupViewModel();
}