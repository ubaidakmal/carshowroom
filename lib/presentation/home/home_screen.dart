import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _buildTopBar(),
              const SizedBox(height: 24),
              _buildHeadline(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 24),
              _buildTrendingBrandsHeader(),
              const SizedBox(height: 12),
              _buildBrandChips(),
              const SizedBox(height: 20),
              _buildCarCard(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.grey200, width: 1.5),
            image: const DecorationImage(
              image: AssetImage(AppAssets.profileAvatar),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Spacer(),
        Column(
          children: [
            Text('Your Location', style: AppTextStyles.labelSmall),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Wapda Town Phase 1, Lahore', style: AppTextStyles.locationTitle),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
              ],
            ),
          ],
        ),
        const Spacer(),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.grey200, width: 1.5),
          ),
          child: const Icon(Icons.notifications_outlined, size: 22, color: AppColors.secondary),
        ),
      ],
    );
  }

  Widget _buildHeadline() {
    return Text(
      'Discover your dream\ncar today easily',
      style: AppTextStyles.headlineLarge,
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.grey50,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, color: AppColors.grey400, size: 22),
                const SizedBox(width: 10),
                Text('Search Leads', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey400)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.tune_rounded, color: AppColors.primary, size: 22),
        ),
      ],
    );
  }

  Widget _buildTrendingBrandsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Trending Brands', style: AppTextStyles.sectionTitle),
        Text('View All', style: AppTextStyles.sectionAction),
      ],
    );
  }

  Widget _buildBrandChips() {
    final brands = ['BMW', 'Mercedes', 'Nissan'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(brands.length, (i) {
          return Padding(
            padding: EdgeInsets.only(right: i < brands.length - 1 ? 10 : 0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.grey200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppAssets.steering,
                    width: 22,
                    height: 22,
                    errorBuilder: (c, e, s) => const Icon(Icons.circle_outlined, size: 22),
                  ),
                  const SizedBox(width: 8),
                  Text(brands[i], style: AppTextStyles.chipLabel),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCarCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.asset(
                  AppAssets.onboardImage1,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    width: double.infinity,
                    height: 180,
                    color: AppColors.grey100,
                    child: const Icon(Icons.directions_car, size: 60, color: AppColors.grey400),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Sale', style: AppTextStyles.bodyMedium),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondary.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.favorite, color: AppColors.red, size: 20),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('BMW Luxury Drive', style: AppTextStyles.sectionTitle.copyWith(fontSize: 16)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 14, color: AppColors.grey600),
                          const SizedBox(width: 4),
                          Text('BMW Luxury Drive', style: AppTextStyles.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Price', style: AppTextStyles.labelSmall),
                    const SizedBox(height: 2),
                    Text('\$30,980', style: AppTextStyles.priceText),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
