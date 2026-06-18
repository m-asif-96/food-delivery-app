import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/ui/common/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return AppColors.primary;
      case 'Preparing':
        return AppColors.statusPreparing;
      case 'Out for Delivery':
        return AppColors.statusOutForDelivery;
      case 'Delivered':
        return AppColors.success;
      default:
        return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
