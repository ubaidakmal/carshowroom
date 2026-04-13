import 'package:flutter/material.dart';

/// App palette: **white** = primary, **black** = secondary (light theme).
abstract final class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF000000);

  static const Color scaffoldBackground = primary;
  static const Color onPrimary = secondary;
  static const Color onSecondary = primary;
}
