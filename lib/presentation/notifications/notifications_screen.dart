import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _notifications = [
    _NotifItem(
      icon: Icons.check_circle_rounded,
      color: AppColors.green,
      title: 'Booking Confirmed',
      subtitle: 'Your test drive for BMW M5 Competition is confirmed for Apr 15.',
      time: '2 min ago',
    ),
    _NotifItem(
      icon: Icons.local_offer_rounded,
      color: AppColors.red,
      title: 'Flash Sale!',
      subtitle: 'Up to 15% off on selected BMW models this weekend only.',
      time: '1 hour ago',
    ),
    _NotifItem(
      icon: Icons.directions_car_rounded,
      color: AppColors.blue,
      title: 'New Arrival',
      subtitle: 'Audi RS7 Sportback 2025 is now available in our showroom.',
      time: '3 hours ago',
    ),
    _NotifItem(
      icon: Icons.star_rounded,
      color: Color(0xFFF9A825),
      title: 'Rate Your Visit',
      subtitle: 'How was your experience at BMW Luxury Drive showroom?',
      time: 'Yesterday',
    ),
    _NotifItem(
      icon: Icons.payment_rounded,
      color: AppColors.green,
      title: 'Payment Received',
      subtitle: 'We received your deposit for the Mercedes AMG GT reservation.',
      time: '2 days ago',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final delay = index * 0.12;
                  final interval = Interval(delay.clamp(0, 0.6), (delay + 0.4).clamp(0, 1), curve: Curves.easeOut);
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final value = interval.transform(_controller.value);
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(offset: Offset(0, 20 * (1 - value)), child: child),
                      );
                    },
                    child: _buildNotifCard(_notifications[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(color: AppColors.grey50, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            ),
          ),
          const SizedBox(width: 14),
          Text('Notifications', style: AppTextStyles.sectionTitle),
          const Spacer(),
          Text('Mark all read', style: AppTextStyles.sectionAction),
        ],
      ),
    );
  }

  Widget _buildNotifCard(_NotifItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, size: 20, color: item.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(item.title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700))),
                    Text(item.time, style: AppTextStyles.labelSmall),
                  ],
                ),
                const SizedBox(height: 4),
                Text(item.subtitle, style: AppTextStyles.bodySmall.copyWith(height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotifItem {
  const _NotifItem({required this.icon, required this.color, required this.title, required this.subtitle, required this.time});
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String time;
}
