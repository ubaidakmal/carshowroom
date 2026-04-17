import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

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
        title: Text('My Reviews', style: AppTextStyles.sectionTitle.copyWith(fontSize: 18)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _ReviewCard(
            title: 'BMW Luxury Drive',
            rating: 5,
            date: '12 Mar 2026',
            text: 'Excellent showroom experience. Staff was helpful and the test drive was smooth.',
          ),
          SizedBox(height: 12),
          _ReviewCard(
            title: 'Mercedes Showroom',
            rating: 4,
            date: '28 Feb 2026',
            text: 'Great selection of AMG models. Waiting time for consultation was a bit long.',
          ),
          SizedBox(height: 12),
          _ReviewCard(
            title: 'Audi Centre',
            rating: 5,
            date: '15 Jan 2026',
            text: 'Loved the RS7 presentation. Would recommend for anyone looking for a sportback.',
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.title, required this.rating, required this.date, required this.text});

  final String title;
  final int rating;
  final String date;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.grey50, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700))),
              Text(date, style: AppTextStyles.labelSmall),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (i) {
              return Icon(
                i < rating ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 18,
                color: i < rating ? const Color(0xFFF9A825) : AppColors.grey200,
              );
            }),
          ),
          const SizedBox(height: 10),
          Text(text, style: AppTextStyles.bodySmall.copyWith(height: 1.45)),
        ],
      ),
    );
  }
}
