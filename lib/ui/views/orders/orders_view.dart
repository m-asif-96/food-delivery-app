import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';
import '../../widgets/order_card.dart';
import 'orders_viewmodel.dart';
import 'package:food_delivery_app/ui/common/app_colors.dart';

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
      backgroundColor: AppColors.background,
      body: viewModel.hasError
          ? ErrorState(message: viewModel.modelError.toString())
          : viewModel.isBusy
              ? const LoadingIndicator()
              : !viewModel.dataReady || viewModel.data!.isEmpty
                  ? const EmptyState(message: 'No orders found.')
              : ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: viewModel.data!.length,
                  itemBuilder: (context, index) {
                    final order = viewModel.data![index];
                    return OrderCard(order: order);
                  },
                ),
    );
  }



  @override
  OrdersViewModel viewModelBuilder(BuildContext context) => OrdersViewModel();
}
