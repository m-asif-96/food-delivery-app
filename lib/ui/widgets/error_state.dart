import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/app_colors.dart';
import '../common/app_typography.dart';
import 'custom_button.dart';

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.w,
              color: AppColors.error,
            ),
            16.verticalSpace,
            Text(
              'Oops! Something went wrong.',
              style: AppTypography.titleLarge,
              textAlign: TextAlign.center,
            ),
            8.verticalSpace,
            Text(
              message,
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              24.verticalSpace,
              CustomButton(
                title: 'Retry',
                onPressed: onRetry,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
