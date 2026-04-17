import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/car_model.dart';
import '../car_detail/car_detail_screen.dart';
import '../home/home_view_model.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> with SingleTickerProviderStateMixin {
  late final HomeViewModel _viewModel;
  late final AnimationController _staggerController;
  int _selectedCategory = 0;

  final _categories = const ['All', 'SUV', 'Sedan', 'Sports', 'Electric', 'Luxury'];

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _staggerController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Explore', style: AppTextStyles.headlineLarge),
                    const SizedBox(height: 4),
                    Text('Find your perfect ride', style: AppTextStyles.bodySmall),
                    const SizedBox(height: 20),
                    _buildCategoryChips(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid.builder(
                itemCount: _viewModel.cars.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final delay = index * 0.1;
                  final interval = Interval(delay.clamp(0, 0.6), (delay + 0.4).clamp(0, 1), curve: Curves.easeOut);
                  return AnimatedBuilder(
                    animation: _staggerController,
                    builder: (context, child) {
                      final value = interval.transform(_staggerController.value);
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 30 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: _ExploreCard(
                      car: _viewModel.cars[index],
                      onTap: () => _openDetail(_viewModel.cars[index]),
                    ),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_categories.length, (i) {
          final isActive = _selectedCategory == i;
          return Padding(
            padding: EdgeInsets.only(right: i < _categories.length - 1 ? 8 : 0),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategory = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.secondary : AppColors.primary,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: isActive ? AppColors.secondary : AppColors.grey200),
                ),
                child: Text(
                  _categories[i],
                  style: AppTextStyles.chipLabel.copyWith(
                    color: isActive ? AppColors.primary : AppColors.secondary,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _ExploreCard extends StatelessWidget {
  const _ExploreCard({required this.car, required this.onTap});

  final CarModel car;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey50,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                    child: Image.asset(
                      car.imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        color: AppColors.grey100,
                        child: const Center(child: Icon(Icons.directions_car, color: AppColors.grey400)),
                      ),
                    ),
                  ),
                  if (car.tag != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(car.tag!, style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary, fontSize: 9)),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(car.name, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.bolt_rounded, size: 12, color: AppColors.grey600),
                        const SizedBox(width: 2),
                        Text('${car.horsepower} HP', style: AppTextStyles.labelSmall),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '\$${car.price.toInt().toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                      style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
