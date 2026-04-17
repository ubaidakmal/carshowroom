import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/car_model.dart';
import '../car_detail/car_detail_screen.dart';
import '../home/home_view_model.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    _viewModel.addListener(_rebuild);
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _viewModel.removeListener(_rebuild);
    _viewModel.dispose();
    super.dispose();
  }

  List<MapEntry<int, CarModel>> get _favorites {
    return _viewModel.cars.asMap().entries.where((e) => e.value.isFavorite).toList();
  }

  @override
  Widget build(BuildContext context) {
    final favs = _favorites;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Favorites', style: AppTextStyles.headlineLarge),
                  const SizedBox(height: 4),
                  Text('${favs.length} cars saved', style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: favs.isEmpty
                  ? _buildEmpty()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: favs.length,
                      itemBuilder: (context, index) {
                        final entry = favs[index];
                        return _FavoriteCard(
                          car: entry.value,
                          onTap: () => _openDetail(entry.value),
                          onRemove: () => _viewModel.toggleFavorite(entry.key),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _openDetail(CarModel car) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => CarDetailScreen(car: car),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border_rounded, size: 64, color: AppColors.grey200),
          const SizedBox(height: 16),
          Text('No favorites yet', style: AppTextStyles.sectionTitle.copyWith(color: AppColors.grey400)),
          const SizedBox(height: 8),
          Text('Tap the heart icon on any car\nto add it here', style: AppTextStyles.bodySmall, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  const _FavoriteCard({required this.car, required this.onTap, required this.onRemove});

  final CarModel car;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.grey50,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                car.imagePath,
                width: 100,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  width: 100,
                  height: 80,
                  color: AppColors.grey100,
                  child: const Icon(Icons.directions_car, color: AppColors.grey400),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(car.name, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text('${car.horsepower} HP • ${car.topSpeed} km/h', style: AppTextStyles.labelSmall),
                  const SizedBox(height: 6),
                  Text(
                    '\$${car.price.toInt().toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                    style: AppTextStyles.priceText.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.red.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.favorite, color: AppColors.red, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
