import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('About', style: AppTextStyles.sectionTitle.copyWith(fontSize: 18)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(Icons.directions_car_rounded, size: 40, color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            Text('Car Showroom', style: AppTextStyles.headlineLarge.copyWith(fontSize: 22)),
            const SizedBox(height: 4),
            Text('Version 1.0.0 (1)', style: AppTextStyles.labelSmall),
            const SizedBox(height: 28),
            Text(
              'Discover, explore, and book your next vehicle in one beautiful app. Built with Flutter for a smooth experience on every device.',
              style: AppTextStyles.bodySmall.copyWith(height: 1.55),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            TextButton(onPressed: () {}, child: const Text('Terms of Service')),
            TextButton(onPressed: () {}, child: const Text('Privacy Policy')),
            TextButton(onPressed: () {}, child: const Text('Licenses')),
          ],
        ),
      ),
    );
  }
}
