import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/ui/common/app_colors.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData? icon;

  const EmptyState({
    super.key,
    required this.message,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 64.w,
              color: AppColors.textTertiary,
            ),
            16.verticalSpace,
          ],
          Text(
            message,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
