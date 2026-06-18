import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/custom_app_bar.dart';
import 'orders_viewmodel.dart';

class OrdersView extends StackedView<OrdersViewModel> {
  const OrdersView({super.key});

  @override
  Widget builder(
    BuildContext context,
    OrdersViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Order History'),
      backgroundColor: Colors.grey[50],
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : !viewModel.dataReady || viewModel.data!.isEmpty
              ? Center(child: Text('No orders found.', style: TextStyle(fontSize: 16.sp)))
              : ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: viewModel.data!.length,
                  itemBuilder: (context, index) {
                    final order = viewModel.data![index];
                    final date = order.createdAt;
                    final formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
                    
                    return Card(
                      margin: EdgeInsets.only(bottom: 16.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
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
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(order.status).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Text(
                                    order.status,
                                    style: TextStyle(
                                      color: _getStatusColor(order.status),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            8.verticalSpace,
                            Text(
                              formattedDate,
                              style: TextStyle(color: Colors.black54, fontSize: 12.sp),
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
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 16.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Preparing':
        return Colors.blue;
      case 'Out for Delivery':
        return Colors.purple;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  OrdersViewModel viewModelBuilder(BuildContext context) => OrdersViewModel();
}
