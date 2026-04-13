import 'dart:ui';

import 'package:car_showroom_app/core/constants/app_assets.dart';
import 'package:car_showroom_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../main_shell/main_shell.dart';

class RootPlaceholderScreen extends StatefulWidget {
  const RootPlaceholderScreen({super.key});

  @override
  State<RootPlaceholderScreen> createState() => _RootPlaceholderScreenState();
}

class _RootPlaceholderScreenState extends State<RootPlaceholderScreen>
    with TickerProviderStateMixin {
  late final AnimationController _carController;
  late final Animation<Offset> _carSlide;

  late final AnimationController _ctaController;
  late final Animation<double> _ctaOpacity;
  late final Animation<double> _ctaBlur;

  late final AnimationController _bounceController;
  late final Animation<double> _bounceOffset;

  @override
  void initState() {
    super.initState();

    // --- Car slides in from top (like a car driving into frame) ---
    _carController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _carSlide = Tween<Offset>(
      begin: const Offset(0, -1.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _carController,
      curve: Curves.easeOutCubic,
    ));

    // --- CTA fades in with blur clearing ---
    _ctaController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _ctaOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctaController, curve: Curves.easeOut),
    );
    _ctaBlur = Tween<double>(begin: 12, end: 0).animate(
      CurvedAnimation(parent: _ctaController, curve: Curves.easeOut),
    );

    // --- Subtle continuous bounce on CTA ---
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _bounceOffset = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -6), weight: 25),
      TweenSequenceItem(tween: Tween(begin: -6, end: 0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0, end: -3), weight: 25),
      TweenSequenceItem(tween: Tween(begin: -3, end: 0), weight: 25),
    ]).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeInOut,
    ));

    _startSequence();
  }

  Future<void> _startSequence() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    _carController.forward();

    await Future<void>.delayed(const Duration(milliseconds: 1000));
    _ctaController.forward();

    await _ctaController.forward().orCancel;
    _bounceController.repeat();
  }

  @override
  void dispose() {
    _carController.dispose();
    _ctaController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Stack(
        children: [
          // --- Animated car image ---
          Center(
            child: SlideTransition(
              position: _carSlide,
              child: Image.asset(AppAssets.onboardImage3, height: 700),
            ),
          ),

          // --- Animated CTA bar ---
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: AnimatedBuilder(
              animation: Listenable.merge([_ctaController, _bounceController]),
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _bounceOffset.value),
                  child: Opacity(
                    opacity: _ctaOpacity.value,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: _ctaBlur.value,
                        sigmaY: _ctaBlur.value,
                      ),
                      child: child,
                    ),
                  ),
                );
              },
              child: _buildCtaBar(),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const MainShell()),
    );
  }

  Widget _buildCtaBar() {
    return GestureDetector(
      onTap: _navigateToHome,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.secondary.withValues(alpha: 0.13),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Image.asset(AppAssets.steering, width: 30, height: 30),
            ),
            Text(
              'Get Started',
              style: AppTextStyles.splashSubtitle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Image.asset(AppAssets.arrow, width: 30, height: 30),
          ],
        ),
      ),
    );
  }
}
