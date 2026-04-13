import 'package:flutter/material.dart';

import 'app_colors.dart';

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

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.secondary,
    height: 1.3,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.secondary,
  );

  static const TextStyle sectionAction = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.grey600,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.secondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.grey600,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.grey600,
  );

  static const TextStyle priceText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.secondary,
  );

  static const TextStyle chipLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.secondary,
  );

  static const TextStyle locationTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.secondary,
  );

  static const TextStyle locationSubtitle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.grey600,
  );
}
