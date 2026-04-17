import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class BrowsingHistoryScreen extends StatelessWidget {
  const BrowsingHistoryScreen({super.key});

  static const _items = [
    ('BMW Luxury Drive', AppAssets.onboardImage1, 'Viewed 2h ago'),
    ('Mercedes AMG GT', AppAssets.car1, 'Viewed yesterday'),
    ('Audi RS7 Sportback', AppAssets.car3, 'Viewed 3 days ago'),
  ];

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
        title: Text('Browsing History', style: AppTextStyles.sectionTitle.copyWith(fontSize: 18)),
        centerTitle: true,
        actions: [
          TextButton(onPressed: () {}, child: Text('Clear', style: AppTextStyles.sectionAction)),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final item = _items[i];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.grey50, borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    item.$2,
                    width: 72,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                      width: 72,
                      height: 56,
                      color: AppColors.grey100,
                      child: const Icon(Icons.directions_car, size: 28, color: AppColors.grey400),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.$1, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text(item.$3, style: AppTextStyles.labelSmall),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: AppColors.grey400),
              ],
            ),
          );
        },
      ),
    );
  }
}
