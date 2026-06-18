import 'package:flutter/material.dart';
import 'package:food_delivery_app/ui/widgets/custom_app_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_state.dart';
import 'order_tracking_viewmodel.dart';
import 'package:food_delivery_app/ui/common/app_colors.dart';

class OrderTrackingView extends StackedView<OrderTrackingViewModel> {
  final String orderId;
  const OrderTrackingView({super.key, required this.orderId});

  @override
  Widget builder(
    BuildContext context,
    OrderTrackingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Order Tracking'),
      backgroundColor: AppColors.background,
      body: viewModel.hasError
          ? ErrorState(message: viewModel.modelError.toString())
          : viewModel.isBusy
              ? const LoadingIndicator()
              : !viewModel.dataReady || viewModel.data == null
                  ? Center(child: Text('Loading order...', style: TextStyle(fontSize: 16.sp)))
          : Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #${viewModel.data!.id.substring(0, 8)}',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    'Amount: \$${viewModel.data!.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16.sp, color: AppColors.textSecondary),
                  ),
                  48.verticalSpace,
                  _buildTimeline(viewModel.data!.status),
                ],
              ),
            ),
    );
  }

  Widget _buildTimeline(String currentStatus) {
    final statuses = ['Pending', 'Preparing', 'Out for Delivery', 'Delivered'];
    int currentIndex = statuses.indexOf(currentStatus);
    if (currentIndex == -1) currentIndex = 0;

    return Column(
      children: List.generate(statuses.length, (index) {
        bool isCompleted = index <= currentIndex;
        bool isCurrent = index == currentIndex;
        bool isLast = index == statuses.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: isCompleted ? AppColors.primary : AppColors.greyMedium,
                    shape: BoxShape.circle,
                  ),
                  child: isCompleted
                      ? Icon(Icons.check, size: 16.w, color: AppColors.white)
                      : null,
                ),
                if (!isLast)
                  Container(
                    width: 2.w,
                    height: 50.h,
                    color: isCompleted && !isCurrent
                        ? AppColors.primary
                        : AppColors.greyMedium,
                  ),
              ],
            ),
            16.horizontalSpace,
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Text(
                  statuses[index],
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    color: isCompleted ? AppColors.textPrimary : AppColors.textTertiary,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  OrderTrackingViewModel viewModelBuilder(BuildContext context) =>
      OrderTrackingViewModel(orderId: orderId);
}
