import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_viewmodel.dart';
import '../../widgets/product_card.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';
import 'package:food_delivery_app/ui/common/app_colors.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.fetchProducts();
  }

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
            ),
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.primary, size: 16.w),
                4.horizontalSpace,
                Text(
                  'New York, USA',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.verticalSpace,
            Text(
              'What would you like\nto eat?',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                height: 1.2,
                color: AppColors.textPrimary,
              ),
            ),
            24.verticalSpace,
            SizedBox(
              height: 40.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.categories.length,
                separatorBuilder: (context, index) => 12.horizontalSpace,
                itemBuilder: (context, index) {
                  final category = viewModel.categories[index];
                  final isSelected = viewModel.selectedCategory == category;
                  return InkWell(
                    onTap: () => viewModel.setCategory(category),
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.greyMedium,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? AppColors.white : AppColors.textPrimary,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            24.verticalSpace,
            Expanded(
              child: viewModel.hasError
                  ? ErrorState(
                      message: viewModel.modelError.toString(),
                      onRetry: viewModel.fetchProducts,
                    )
                  : viewModel.isBusy
                      ? const LoadingIndicator()
                      : viewModel.filteredProducts.isEmpty
                          ? const EmptyState(
                              message: 'No products found.',
                            )
                      : GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                          ),
                          itemCount: viewModel.filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = viewModel.filteredProducts[index];
                            return ProductCard(
                              product: product,
                              onAdd: () {
                                viewModel.addToCart(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${product.name} added to cart!'),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
