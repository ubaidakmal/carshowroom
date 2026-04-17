import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/saved_booking.dart';
import '../../data/services/booking_local_storage.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  late Future<List<SavedBooking>> _future;

  @override
  void initState() {
    super.initState();
    _future = BookingLocalStorage.instance.loadBookings();
    BookingLocalStorage.instance.addListener(_onStorageChanged);
  }

  void _onStorageChanged() {
    setState(() {
      _future = BookingLocalStorage.instance.loadBookings();
    });
  }

  @override
  void dispose() {
    BookingLocalStorage.instance.removeListener(_onStorageChanged);
    super.dispose();
  }

  void _reload() {
    setState(() {
      _future = BookingLocalStorage.instance.loadBookings();
    });
  }

  String _formatPrice(double p) {
    return '\$${p.toInt().toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
  }

  String _formatDate(int ms) {
    final d = DateTime.fromMillisecondsSinceEpoch(ms);
    return '${d.day}/${d.month}/${d.year}';
  }

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
        title: Text('My Bookings', style: AppTextStyles.sectionTitle.copyWith(fontSize: 18)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<SavedBooking>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.secondary, strokeWidth: 2));
          }
          final list = snapshot.data ?? [];
          if (list.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_note_rounded, size: 64, color: AppColors.grey200),
                    const SizedBox(height: 16),
                    Text('No bookings yet', style: AppTextStyles.sectionTitle.copyWith(color: AppColors.grey400)),
                    const SizedBox(height: 8),
                    Text(
                      'Confirm a booking from any car detail\nto see it here.',
                      style: AppTextStyles.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          return RefreshIndicator(
            color: AppColors.secondary,
            onRefresh: () async => _reload(),
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: list.length,
              itemBuilder: (context, i) {
                final b = list[i];
                return Dismissible(
                  key: Key(b.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(color: AppColors.red.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(16)),
                    child: const Icon(Icons.delete_outline, color: AppColors.red),
                  ),
                  onDismissed: (_) async {
                    await BookingLocalStorage.instance.removeBooking(b.id);
                    _reload();
                  },
                  child: _BookingCard(
                    booking: b,
                    formatPrice: _formatPrice,
                    formatDate: _formatDate,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  const _BookingCard({
    required this.booking,
    required this.formatPrice,
    required this.formatDate,
  });

  final SavedBooking booking;
  final String Function(double) formatPrice;
  final String Function(int) formatDate;

  @override
  Widget build(BuildContext context) {
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
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              booking.carImagePath,
              width: 88,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                width: 88,
                height: 72,
                color: AppColors.grey100,
                child: const Icon(Icons.directions_car, color: AppColors.grey400),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(booking.carName, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(booking.bookingType, style: AppTextStyles.labelSmall.copyWith(color: AppColors.green, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 12, color: AppColors.grey600),
                    const SizedBox(width: 4),
                    Text('${booking.dateLabel} • ${booking.time}', style: AppTextStyles.labelSmall),
                  ],
                ),
                const SizedBox(height: 4),
                Text(formatPrice(booking.carPrice), style: AppTextStyles.priceText.copyWith(fontSize: 15)),
                Text('Booked ${formatDate(booking.createdAtMs)}', style: AppTextStyles.labelSmall.copyWith(fontSize: 10)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(booking.status, style: AppTextStyles.labelSmall.copyWith(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
