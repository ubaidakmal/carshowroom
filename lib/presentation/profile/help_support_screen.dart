import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
        title: Text('Help & Support', style: AppTextStyles.sectionTitle.copyWith(fontSize: 18)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.grey50, AppColors.grey100.withValues(alpha: 0.5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('How can we help?', style: AppTextStyles.sectionTitle.copyWith(fontSize: 17)),
                const SizedBox(height: 6),
                Text('Search FAQs or reach our team.', style: AppTextStyles.bodySmall),
                const SizedBox(height: 14),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search help articles...',
                    hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey400),
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.grey400),
                    filled: true,
                    fillColor: AppColors.primary,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Popular topics', style: AppTextStyles.labelSmall),
          const SizedBox(height: 10),
          ...[
            'Booking a test drive',
            'Financing & payments',
            'Returns & cancellations',
            'Warranty information',
          ].map((t) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: AppColors.grey50, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(child: Text(t, style: AppTextStyles.bodyMedium)),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.grey400, size: 20),
                  ],
                ),
              )),
          const SizedBox(height: 24),
          Text('Contact', style: AppTextStyles.labelSmall),
          const SizedBox(height: 10),
          _contactRow(Icons.chat_outlined, 'Live chat', 'Mon–Sat, 9am–8pm'),
          _contactRow(Icons.email_outlined, 'Email', 'support@carshowroom.app'),
          _contactRow(Icons.phone_outlined, 'Phone', '+92 300 0000000'),
        ],
      ),
    );
  }

  Widget _contactRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: AppColors.grey50, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, size: 20, color: AppColors.secondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                Text(value, style: AppTextStyles.labelSmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
