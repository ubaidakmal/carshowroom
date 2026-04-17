import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF000000);

  static const Color scaffoldBackground = primary;
  static const Color onPrimary = secondary;
  static const Color onSecondary = primary;

  static const Color grey50 = Color(0xFFF5F5F5);
  static const Color grey100 = Color(0xFFF0F0F0);
  static const Color grey200 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);

  static const Color red = Color(0xFFE53935);
  static const Color saleBadge = Color(0xFFF5F5F5);
  static const Color green = Color(0xFF2E7D32);
  static const Color blue = Color(0xFF1565C0);
}
