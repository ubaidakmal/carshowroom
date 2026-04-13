import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/car_model.dart';

class Car360ViewScreen extends StatefulWidget {
  const Car360ViewScreen({super.key, required this.car});

  final CarModel car;

  @override
  State<Car360ViewScreen> createState() => _Car360ViewScreenState();
}

class _Car360ViewScreenState extends State<Car360ViewScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entryController;
  late final Animation<double> _entryOpacity;
  late final Animation<double> _entryScale;

  late final AnimationController _uiController;
  late final Animation<double> _uiFade;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _entryOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _entryController, curve: const Interval(0, 0.5, curve: Curves.easeOut)),
    );
    _entryScale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOutCubic),
    );

    _uiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _uiFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _uiController, curve: Curves.easeOut),
    );

    _startEntry();
  }

  Future<void> _startEntry() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;
    _entryController.forward();
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    _uiController.forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    _uiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackground(),
          _build3DViewer(),
          _buildTopBar(topPadding),
          _buildBottomInfo(),
          _buildHint(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: CustomPaint(painter: _GridPainter()),
    );
  }

  Widget _build3DViewer() {
    return AnimatedBuilder(
      animation: _entryController,
      builder: (context, child) {
        return Opacity(
          opacity: _entryOpacity.value,
          child: Transform.scale(
            scale: _entryScale.value,
            child: child,
          ),
        );
      },
      child: ModelViewer(
        src: AppAssets.bmwModel3D2,
        alt: '3D model of ${widget.car.name}',
        autoRotate: true,
        autoRotateDelay: 0,
        rotationPerSecond: '20deg',
        cameraControls: true,
        disableZoom: false,
        disablePan: false,
        disableTap: false,
        touchAction: TouchAction.panY,
        backgroundColor: Colors.transparent,
        interactionPrompt: InteractionPrompt.auto,
        interactionPromptThreshold: 500,
        cameraOrbit: '0deg 75deg 105%',
        minCameraOrbit: 'auto 30deg auto',
        maxCameraOrbit: 'auto 90deg auto',
        shadowIntensity: 1,
        shadowSoftness: 1,
        exposure: 1.0,
      ),
    );
  }

  Widget _buildTopBar(double topPadding) {
    return Positioned(
      top: topPadding + 12,
      left: 20,
      right: 20,
      child: FadeTransition(
        opacity: _uiFade,
        child: Row(
          children: [
            _glassButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: () => Navigator.of(context).pop(),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
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
            const Spacer(),
            const SizedBox(width: 42),
          ],
        ),
      ),
    );
  }

  Widget _glassButton({required IconData icon, required VoidCallback onTap}) {
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
              color: AppColors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: Icon(icon, size: 20, color: AppColors.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomInfo() {
    final car = widget.car;
    return Positioned(
      left: 20,
      right: 20,
      bottom: MediaQuery.of(context).padding.bottom + 20,
      child: FadeTransition(
        opacity: _uiFade,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          car.name,
                          style: AppTextStyles.sectionTitle.copyWith(color: AppColors.primary, fontSize: 18),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${car.year}',
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _miniSpec(Icons.speed_rounded, '${car.topSpeed} km/h'),
                      _miniSpec(Icons.bolt_rounded, '${car.horsepower} HP'),
                      _miniSpec(Icons.timer_outlined, '${car.acceleration}s'),
                      _miniSpec(Icons.settings_rounded, car.engine.split(' ').last),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _miniSpec(IconData icon, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.primary.withValues(alpha: 0.6)),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildHint() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: MediaQuery.of(context).padding.bottom + 150,
      child: FadeTransition(
        opacity: _uiFade,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.touch_app_rounded, size: 16, color: AppColors.primary.withValues(alpha: 0.5)),
            const SizedBox(width: 6),
            Text(
              'Drag to rotate • Pinch to zoom',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.04)
      ..strokeWidth = 0.5;

    const spacing = 40.0;
    for (var x = 0.0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final centerPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.06)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      centerPaint,
    );
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      centerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
