import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
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
      appBar: AppBar(
        title: const Text('Track Order', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : !viewModel.dataReady || viewModel.data == null
              ? const Center(child: Text('Loading order...'))
              : Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${viewModel.data!.id.substring(0, 8)}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Amount: \$${viewModel.data!.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const SizedBox(height: 48),
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
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isCompleted ? Colors.orange : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: isCompleted
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 50,
                    color: isCompleted && !isCurrent ? Colors.orange : Colors.grey[300],
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  statuses[index],
                  style: TextStyle(
                    fontSize: 18,
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
