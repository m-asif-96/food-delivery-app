import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
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
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : !viewModel.dataReady || viewModel.data!.isEmpty
              ? const Center(
                  child: Text(
                    'No new notifications.',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
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
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: notification.isRead ? Colors.white : Colors.orange[50],
                          borderRadius: BorderRadius.circular(12),
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
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: notification.isRead ? Colors.grey[100] : Colors.orange[100],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.notifications,
                                color: notification.isRead ? Colors.grey : Colors.orange,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification.title,
                                    style: TextStyle(
                                      fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    notification.message,
                                    style: const TextStyle(color: Colors.black54),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    formattedDate,
                                    style: const TextStyle(color: Colors.black38, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            if (!notification.isRead)
                              Container(
                                width: 8,
                                height: 8,
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

