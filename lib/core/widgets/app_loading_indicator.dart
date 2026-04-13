import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Shared loading indicator (custom widget baseline).
class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.size = 32, this.strokeWidth = 3});

  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: AppColors.secondary,
      ),
    );
  }
}
