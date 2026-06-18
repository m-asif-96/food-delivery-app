import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/custom_app_bar.dart';
import 'notifications_viewmodel.dart';

class NotificationsView extends StackedView<NotificationsViewModel> {
  const NotificationsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    NotificationsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar(title: 'Notifications'),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : !viewModel.dataReady || viewModel.data!.isEmpty
              ? Center(
                  child: Text(
                    'No new notifications.',
                    style: TextStyle(color: Colors.black54, fontSize: 16.sp),
                  ),
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
                          color: notification.isRead ? Colors.white : Colors.orange[50],
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: notification.isRead ? Colors.grey[200]! : Colors.orange[200]!,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
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
                                color: notification.isRead ? Colors.grey[100] : Colors.orange[100],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.notifications,
                                color: notification.isRead ? Colors.grey : Colors.orange,
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
                                      color: Colors.black87,
                                    ),
                                  ),
                                  4.verticalSpace,
                                  Text(
                                    notification.message,
                                    style: TextStyle(color: Colors.black54, fontSize: 14.sp),
                                  ),
                                  8.verticalSpace,
                                  Text(
                                    formattedDate,
                                    style: TextStyle(color: Colors.black38, fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                            if (!notification.isRead)
                              Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: const BoxDecoration(
                                  color: Colors.orange,
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

