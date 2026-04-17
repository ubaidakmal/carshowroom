import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _bookings = true;
  bool _promos = true;
  bool _news = false;
  bool _messages = true;

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
        title: Text('Notifications', style: AppTextStyles.sectionTitle.copyWith(fontSize: 18)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Push notifications', style: AppTextStyles.labelSmall),
          const SizedBox(height: 12),
          _tile('Booking updates', 'Confirmations & reminders', _bookings, (v) => setState(() => _bookings = v)),
          _tile('Offers & promotions', 'Sales and limited deals', _promos, (v) => setState(() => _promos = v)),
          _tile('News & tips', 'Car care and showroom news', _news, (v) => setState(() => _news = v)),
          _tile('Messages', 'Chat from dealerships', _messages, (v) => setState(() => _messages = v)),
        ],
      ),
    );
  }

  Widget _tile(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(color: AppColors.grey50, borderRadius: BorderRadius.circular(14)),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.secondary,
        title: Text(title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: AppTextStyles.labelSmall),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
