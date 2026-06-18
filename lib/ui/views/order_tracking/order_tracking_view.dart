import 'package:flutter/material.dart';
import 'package:food_delivery_app/ui/widgets/custom_app_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'order_tracking_viewmodel.dart';

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
      backgroundColor: Colors.grey[50],
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
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
                    style: TextStyle(fontSize: 16.sp, color: Colors.black54),
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
                    color: isCompleted ? Colors.orange : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: isCompleted
                      ? Icon(Icons.check, size: 16.w, color: Colors.white)
                      : null,
                ),
                if (!isLast)
                  Container(
                    width: 2.w,
                    height: 50.h,
                    color: isCompleted && !isCurrent
                        ? Colors.orange
                        : Colors.grey[300],
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
                    color: isCompleted ? Colors.black87 : Colors.black38,
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
