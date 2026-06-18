import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';
import 'notifications_viewmodel.dart';
import 'package:food_delivery_app/ui/common/app_colors.dart';

class NotificationsView extends StackedView<NotificationsViewModel> {
  const NotificationsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    NotificationsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Notifications'),
      body: viewModel.hasError
          ? ErrorState(message: viewModel.modelError.toString())
          : viewModel.isBusy
              ? const LoadingIndicator()
              : !viewModel.dataReady || viewModel.data!.isEmpty
                  ? const EmptyState(
                  message: 'No new notifications.',
                  icon: Icons.notifications_off_outlined,
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: viewModel.data!.length,
                  itemBuilder: (context, index) {
                    final notification = viewModel.data![index];
                    final date = notification.createdAt;
                    final formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
                    
                    return GestureDetector(
                      onTap: () {
                        if (!notification.isRead) {
                          viewModel.markAsRead(notification.id);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: notification.isRead ? AppColors.white : AppColors.primaryLightest,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: notification.isRead ? AppColors.greyLight : AppColors.primaryLight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            )
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: notification.isRead ? AppColors.greyLightest : AppColors.primaryLight,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.notifications,
                                color: notification.isRead ? AppColors.grey : AppColors.primary,
                              ),
                            ),
                            16.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification.title,
                                    style: TextStyle(
                                      fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                                      fontSize: 16.sp,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  4.verticalSpace,
                                  Text(
                                    notification.message,
                                    style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
                                  ),
                                  8.verticalSpace,
                                  Text(
                                    formattedDate,
                                    style: TextStyle(color: AppColors.textTertiary, fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                            if (!notification.isRead)
                              Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  @override
  NotificationsViewModel viewModelBuilder(BuildContext context) => NotificationsViewModel();
}

