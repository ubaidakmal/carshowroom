import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class MyAddressesScreen extends StatelessWidget {
  const MyAddressesScreen({super.key});

  static const _addresses = [
    _Addr('Home', 'House 12, Block B, Wapda Town Phase 1', 'Lahore, Punjab', true),
    _Addr('Office', 'Tech Park, 3rd Floor', 'Gulberg III, Lahore', false),
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
        title: Text('My Addresses', style: AppTextStyles.sectionTitle.copyWith(fontSize: 18)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _addresses.length,
        itemBuilder: (context, i) {
          final a = _addresses[i];
          return AnimatedContainer(
            duration: Duration(milliseconds: 300 + i * 50),
            curve: Curves.easeOut,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.grey50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: a.isDefault ? AppColors.secondary.withValues(alpha: 0.2) : AppColors.grey200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(a.label, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
                    if (a.isDefault) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('Default', style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary, fontSize: 9)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Text(a.line1, style: AppTextStyles.bodySmall),
                Text(a.line2, style: AppTextStyles.bodySmall),
                const SizedBox(height: 12),
                Row(
                  children: [
                    TextButton(onPressed: () {}, child: const Text('Edit')),
                    TextButton(onPressed: () {}, child: Text('Remove', style: TextStyle(color: AppColors.red.withValues(alpha: 0.8)))),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Addr {
  const _Addr(this.label, this.line1, this.line2, this.isDefault);
  final String label;
  final String line1;
  final String line2;
  final bool isDefault;
}
