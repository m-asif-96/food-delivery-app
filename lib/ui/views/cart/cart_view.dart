import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/custom_app_bar.dart';
import 'cart_viewmodel.dart';

class CartView extends StackedView<CartViewModel> {
  const CartView({super.key});

  @override
  Widget builder(
    BuildContext context,
    CartViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar(title: 'Shopping Cart'),
      body: viewModel.cartItems.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18.sp, color: Colors.black54),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(16.w),
                    itemCount: viewModel.cartItems.length,
                    separatorBuilder: (_, __) => 16.verticalSpace,
                    itemBuilder: (context, index) {
                      final item = viewModel.cartItems[index];
                      return Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: item.product.imageUrl.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: item.product.imageUrl,
                                      width: 80.w,
                                      height: 80.w,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        width: 80.w,
                                        height: 80.w,
                                        color: Colors.grey[200],
                                        child: Center(
                                          child: SizedBox(
                                            width: 16.w,
                                            height: 16.w,
                                            child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.orange),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => Container(
                                        width: 80.w,
                                        height: 80.w,
                                        color: Colors.orange[100],
                                        child: Icon(Icons.fastfood, color: Colors.orange, size: 24.w),
                                      ),
                                    )
                                  : Container(
                                      width: 80.w,
                                      height: 80.w,
                                      color: Colors.orange[100],
                                      child: Icon(Icons.fastfood, color: Colors.orange, size: 24.w),
                                    ),
                            ),
                            16.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                  ),
                                  4.verticalSpace,
                                  Text(
                                    '\$${item.product.price.toStringAsFixed(2)}',
                                    style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () => viewModel.updateQuantity(item.product, item.quantity - 1),
                                  color: Colors.black54,
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () => viewModel.updateQuantity(item.product, item.quantity + 1),
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      )
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${viewModel.totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.orange),
                            ),
                          ],
                        ),
                        16.verticalSpace,
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            onPressed: viewModel.isBusy
                                ? null
                                : () => viewModel.checkout(),
                            child: viewModel.isBusy
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'Checkout',
                                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  CartViewModel viewModelBuilder(BuildContext context) => CartViewModel();
}
