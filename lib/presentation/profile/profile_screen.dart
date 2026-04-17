import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_user.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/services/booking_local_storage.dart';
import 'about_screen.dart';
import 'browsing_history_screen.dart';
import 'edit_profile_screen.dart';
import 'help_support_screen.dart';
import 'my_addresses_screen.dart';
import 'my_bookings_screen.dart';
import 'notification_settings_screen.dart';
import 'payment_methods_screen.dart';
import 'privacy_security_screen.dart';
import 'reviews_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _bookingCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700))..forward();
    BookingLocalStorage.instance.addListener(_onBookingsChanged);
    _loadBookingCount();
  }

  void _onBookingsChanged() {
    _loadBookingCount();
  }

  Future<void> _loadBookingCount() async {
    final n = await BookingLocalStorage.instance.count();
    if (mounted) setState(() => _bookingCount = n);
  }

  @override
  void dispose() {
    BookingLocalStorage.instance.removeListener(_onBookingsChanged);
    _controller.dispose();
    super.dispose();
  }

  void _push(Widget page) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final value = CurvedAnimation(parent: _controller, curve: Curves.easeOut).value;
              return Opacity(
                opacity: value,
                child: Transform.translate(offset: Offset(0, 20 * (1 - value)), child: child),
              );
            },
            child: Column(
              children: [
                const SizedBox(height: 16),
                _buildHeader(),
                const SizedBox(height: 30),
                _buildStatsRow(),
                const SizedBox(height: 30),
                _buildSection('Account', [
                  _NavItem(Icons.person_outline_rounded, 'Edit Profile', () => _push(const EditProfileScreen())),
                  _NavItem(Icons.location_on_outlined, 'My Addresses', () => _push(const MyAddressesScreen())),
                  _NavItem(Icons.credit_card_rounded, 'Payment Methods', () => _push(const PaymentMethodsScreen())),
                ]),
                const SizedBox(height: 20),
                _buildSection('Activity', [
                  _NavItem(Icons.receipt_long_rounded, 'My Bookings', () => _push(const MyBookingsScreen())),
                  _NavItem(Icons.history_rounded, 'Browsing History', () => _push(const BrowsingHistoryScreen())),
                  _NavItem(Icons.star_outline_rounded, 'Reviews', () => _push(const ReviewsScreen())),
                ]),
                const SizedBox(height: 20),
                _buildSection('Preferences', [
                  _NavItem(Icons.notifications_outlined, 'Notifications', () => _push(const NotificationSettingsScreen())),
                  _NavItem(Icons.shield_outlined, 'Privacy & Security', () => _push(const PrivacySecurityScreen())),
                  _NavItem(Icons.help_outline_rounded, 'Help & Support', () => _push(const HelpSupportScreen())),
                  _NavItem(Icons.info_outline_rounded, 'About', () => _push(const AboutScreen())),
                ]),
                const SizedBox(height: 24),
                _buildLogout(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.grey200, width: 2),
            image: const DecorationImage(image: AssetImage(AppAssets.profileAvatar), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 14),
        Text(AppUser.name, style: AppTextStyles.sectionTitle.copyWith(fontSize: 20)),
        const SizedBox(height: 4),
        Text(AppUser.email, style: AppTextStyles.bodySmall),
        const SizedBox(height: 2),
        Text(AppUser.phone, style: AppTextStyles.labelSmall.copyWith(color: AppColors.grey600)),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatItem('$_bookingCount', 'Bookings'),
        _buildStatDivider(),
        _buildStatItem('5', 'Favorites'),
        _buildStatDivider(),
        _buildStatItem('3', 'Reviews'),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: AppTextStyles.headlineLarge.copyWith(fontSize: 22)),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.labelSmall),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(width: 1, height: 36, color: AppColors.grey200);
  }

  Widget _buildSection(String title, List<_NavItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.sectionTitle.copyWith(fontSize: 16)),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.grey50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: List.generate(items.length, (i) {
              final item = items[i];
              return Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.vertical(
                        top: i == 0 ? const Radius.circular(16) : Radius.zero,
                        bottom: i == items.length - 1 ? const Radius.circular(16) : Radius.zero,
                      ),
                      onTap: item.onTap,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppColors.secondary.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(item.icon, size: 18, color: AppColors.secondary),
                            ),
                            const SizedBox(width: 14),
                            Expanded(child: Text(item.label, style: AppTextStyles.bodyMedium)),
                            const Icon(Icons.chevron_right_rounded, size: 20, color: AppColors.grey400),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (i < items.length - 1)
                    Divider(height: 1, indent: 66, color: AppColors.grey200.withValues(alpha: 0.6)),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildLogout() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.red.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text('Log Out', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.red, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.icon, this.label, this.onTap);
  final IconData icon;
  final String label;
  final VoidCallback onTap;
}
