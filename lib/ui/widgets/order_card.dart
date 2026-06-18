import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/order_model.dart';
import 'status_badge.dart';
import 'package:food_delivery_app/ui/common/app_colors.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final date = order.createdAt;
    final formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #${order.id.substring(0, 8)}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                  StatusBadge(status: order.status),
                ],
              ),
              8.verticalSpace,
              Text(
                formattedDate,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
              ),
              Divider(height: 24.h),
              ...order.items.map((item) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${item.quantity}x ${item.product.name}', style: TextStyle(fontSize: 14.sp)),
                        Text('\$${item.totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 14.sp)),
                      ],
                    ),
                  )),
              Divider(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                  Text(
                    '\$${order.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 16.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
