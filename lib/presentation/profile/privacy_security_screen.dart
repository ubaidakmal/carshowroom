import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

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
        title: Text('Privacy & Security', style: AppTextStyles.sectionTitle.copyWith(fontSize: 18)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _section(
            'Data',
            [
              _row(Icons.download_outlined, 'Download my data', 'Get a copy of your account data'),
              _row(Icons.delete_outline_rounded, 'Delete account', 'Permanently remove your data', danger: true),
            ],
          ),
          const SizedBox(height: 24),
          _section(
            'Security',
            [
              _row(Icons.lock_outline_rounded, 'Change password', 'Last changed 3 months ago'),
              _row(Icons.fingerprint_rounded, 'Biometric login', 'Use Face ID or fingerprint'),
              _row(Icons.devices_rounded, 'Active sessions', 'Manage signed-in devices'),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'We use your data only to improve your showroom experience and never sell it to third parties.',
            style: AppTextStyles.bodySmall.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(color: AppColors.grey50, borderRadius: BorderRadius.circular(16)),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _row(IconData icon, String title, String subtitle, {bool danger = false}) {
    return ListTile(
      leading: Icon(icon, color: danger ? AppColors.red : AppColors.secondary, size: 22),
      title: Text(title, style: AppTextStyles.bodyMedium.copyWith(color: danger ? AppColors.red : null, fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: AppTextStyles.labelSmall),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.grey400, size: 20),
      onTap: () {},
    );
  }
}
