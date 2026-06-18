import 'package:flutter/material.dart';

class AppColors {
  // Primary brand color
  static const Color primary = Colors.orange;
  static const Color primaryLight = Color(0xFFFFE0B2); // Colors.orange[100]
  static const Color primaryLightest = Color(0xFFFFF3E0); // Colors.orange[50]
  
  // Backgrounds
  static const Color background = Color(0xFFFAFAFA); // Colors.grey[50]
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color black12 = Colors.black12;
  static const Color transparent = Colors.transparent;
  
  // Text Colors
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;
  static const Color textTertiary = Colors.black38;
  
  // Greys for borders, dividers, disabled states
  static const Color greyLightest = Color(0xFFF5F5F5); // Colors.grey[100]
  static const Color greyLight = Color(0xFFEEEEEE); // Colors.grey[200]
  static const Color greyMedium = Color(0xFFE0E0E0); // Colors.grey[300]
  static const Color grey = Colors.grey;
  
  // Semantic Colors
  static const Color error = Colors.red;
  static const Color success = Colors.green;
  
  // Status Colors (specific to the app)
  static const Color statusPending = Colors.orange;
  static const Color statusPreparing = Colors.blue;
  static const Color statusOutForDelivery = Colors.purple;
  static const Color statusDelivered = Colors.green;
  static const Color statusUnknown = Colors.grey;
}
