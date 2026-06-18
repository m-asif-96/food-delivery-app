import 'package:flutter/material.dart';
import 'package:food_delivery_app/ui/common/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  final Color color;

  const LoadingIndicator({super.key, this.color = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
