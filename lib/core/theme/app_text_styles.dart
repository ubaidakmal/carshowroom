import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Central text styles — extend as screens are added.
abstract final class AppTextStyles {
  AppTextStyles._();

  static const TextStyle splashTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.secondary,
    letterSpacing: 0.5,
  );

  static const TextStyle splashSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.secondary,
  );
}
