import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/car_model.dart';
import '../car_360_view/car_360_view_screen.dart';
import 'car_detail_view_model.dart';

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({super.key, required this.car});

  final CarModel car;

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen>
    with TickerProviderStateMixin {
  late final CarDetailViewModel _viewModel;

  late final AnimationController _contentController;
  late final Animation<Offset> _slideUp;
  late final Animation<double> _fadeIn;

  late final AnimationController _specsController;

  @override
  void initState() {
    super.initState();
    _viewModel = CarDetailViewModel(car: widget.car);
    _viewModel.addListener(_rebuild);

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _contentController, curve: Curves.easeOutCubic));
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );

    _specsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    Future<void>.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _contentController.forward();
    });
    Future<void>.delayed(const Duration(milliseconds: 700), () {
      if (mounted) _specsController.forward();
    });
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _viewModel.removeListener(_rebuild);
    _viewModel.dispose();
    _contentController.dispose();
    _specsController.dispose();
    super.dispose();
  }

  String _formatPrice(double price) {
    final intPrice = price.toInt();
    final buffer = StringBuffer('\$');
    final str = intPrice.toString();
    for (var i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write(',');
      buffer.write(str[i]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final car = _viewModel.car;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: _buildHeroSection(car, topPadding)),
                SliverToBoxAdapter(
                  child: SlideTransition(
                    position: _slideUp,
                    child: FadeTransition(
                      opacity: _fadeIn,
                      child: _buildDetailsBody(car),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildBookingBar(car),
        ],
      ),
    );
  }

  Widget _buildHeroSection(CarModel car, double topPadding) {
    return Container(
      color: AppColors.grey50,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: topPadding),
            child: Hero(
              tag: 'car-image-${car.imagePath}',
              child: Image.asset(
                car.imagePath,
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  width: double.infinity,
                  height: 280,
                  color: AppColors.grey100,
                  child: const Icon(Icons.directions_car, size: 80, color: AppColors.grey400),
                ),
              ),
            ),
          ),

          Positioned(
            top: topPadding + 12,
            left: 16,
            child: _circleButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),

          Positioned(
            top: topPadding + 12,
            right: 16,
            child: _circleButton(
              icon: car.isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
              iconColor: car.isFavorite ? AppColors.red : AppColors.secondary,
              onTap: _viewModel.toggleFavorite,
            ),
          ),

          Positioned(
            bottom: 16,
            right: 20,
            child: _build360Button(),
          ),
        ],
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = AppColors.secondary,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.7),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
        ),
      ),
    );
  }

  Widget _build360Button() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder<void>(
            transitionDuration: const Duration(milliseconds: 600),
            reverseTransitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) =>
                Car360ViewScreen(car: _viewModel.car),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.view_in_ar_rounded, size: 18, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  '360° View',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsBody(CarModel car) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(car.name, style: AppTextStyles.headlineLarge.copyWith(fontSize: 22)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: AppColors.grey600),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(car.location, style: AppTextStyles.bodySmall, overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (car.tag != null)
                Container(
                  margin: const EdgeInsets.only(left: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(car.tag!, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary)),
                ),
            ],
          ),

          const SizedBox(height: 20),
          _buildColorSelector(),

          const SizedBox(height: 24),
          Text('Description', style: AppTextStyles.sectionTitle),
          const SizedBox(height: 8),
          Text(car.description, style: AppTextStyles.bodySmall.copyWith(fontSize: 13, height: 1.6)),

          const SizedBox(height: 24),
          Text('Specifications', style: AppTextStyles.sectionTitle),
          const SizedBox(height: 14),
          _buildSpecsGrid(car),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildColorSelector() {
    final colors = [
      AppColors.secondary,
      const Color(0xFF607D8B),
      AppColors.primary,
      const Color(0xFFC62828),
      const Color(0xFF1565C0),
    ];
    return Row(
      children: [
        Text('Color', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(width: 16),
        ...List.generate(colors.length, (i) {
          final isSelected = _viewModel.selectedColorIndex == i;
          return GestureDetector(
            onTap: () => _viewModel.selectColor(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: colors[i],
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.secondary : AppColors.grey200,
                  width: isSelected ? 2.5 : 1.5,
                ),
                boxShadow: isSelected
                    ? [BoxShadow(color: colors[i].withValues(alpha: 0.4), blurRadius: 6, offset: const Offset(0, 2))]
                    : null,
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSpecsGrid(CarModel car) {
    final specs = [
      _SpecItem(Icons.speed_rounded, 'Top Speed', '${car.topSpeed} km/h'),
      _SpecItem(Icons.bolt_rounded, 'Power', '${car.horsepower} HP'),
      _SpecItem(Icons.timer_outlined, '0–100 km/h', '${car.acceleration}s'),
      _SpecItem(Icons.settings_rounded, 'Transmission', car.transmission.split(' ').first),
      _SpecItem(Icons.local_gas_station_rounded, 'Fuel', car.fuelType),
      _SpecItem(Icons.calendar_today_rounded, 'Year', '${car.year}'),
    ];

    return AnimatedBuilder(
      animation: _specsController,
      builder: (context, child) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: specs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {
            final delay = index * 0.12;
            final itemProgress = Interval(delay, (delay + 0.5).clamp(0, 1), curve: Curves.easeOut);
            final value = itemProgress.transform(_specsController.value);
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: _buildSpecTile(specs[index]),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSpecTile(_SpecItem spec) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(spec.icon, size: 18, color: AppColors.secondary),
          ),
          const SizedBox(height: 8),
          Text(spec.label, style: AppTextStyles.labelSmall, textAlign: TextAlign.center),
          const SizedBox(height: 2),
          Text(
            spec.value,
            style: AppTextStyles.bodyMedium.copyWith(fontSize: 12, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildBookingBar(CarModel car) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price', style: AppTextStyles.labelSmall),
              const SizedBox(height: 2),
              Text(_formatPrice(car.price), style: AppTextStyles.priceText.copyWith(fontSize: 22)),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Book Now',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecItem {
  const _SpecItem(this.icon, this.label, this.value);
  final IconData icon;
  final String label;
  final String value;
}
