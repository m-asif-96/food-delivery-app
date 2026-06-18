import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/empty_state.dart';
import 'cart_viewmodel.dart';
import 'package:food_delivery_app/ui/common/app_colors.dart';

class CartView extends StackedView<CartViewModel> {
  const CartView({super.key});

  @override
  Widget builder(BuildContext context, CartViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Shopping Cart'),
      body: viewModel.cartItems.isEmpty
          ? const EmptyState(
              message: 'Your cart is empty',
              icon: Icons.shopping_cart_outlined,
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
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
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
                                        color: AppColors.greyLight,
                                        child: Center(
                                          child: SizedBox(
                                            width: 16.w,
                                            height: 16.w,
                                            child:
                                                const CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: AppColors.primary,
                                                ),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            width: 80.w,
                                            height: 80.w,
                                            color: AppColors.primaryLight,
                                            child: Icon(
                                              Icons.fastfood,
                                              color: AppColors.primary,
                                              size: 24.w,
                                            ),
                                          ),
                                    )
                                  : Container(
                                      width: 80.w,
                                      height: 80.w,
                                      color: AppColors.primaryLight,
                                      child: Icon(
                                        Icons.fastfood,
                                        color: AppColors.primary,
                                        size: 24.w,
                                      ),
                                    ),
                            ),
                            16.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  4.verticalSpace,
                                  Text(
                                    '\$${item.product.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () => viewModel.updateQuantity(
                                    item.product,
                                    item.quantity - 1,
                                  ),
                                  color: AppColors.textSecondary,
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () => viewModel.updateQuantity(
                                    item.product,
                                    item.quantity + 1,
                                  ),
                                  color: AppColors.textSecondary,
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
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.12),
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
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
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${viewModel.totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        16.verticalSpace,
                        CustomButton(
                          title: 'Checkout',
                          onPressed: viewModel.checkout,
                          isBusy: viewModel.isBusy,
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
