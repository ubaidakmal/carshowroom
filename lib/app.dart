import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'presentation/splash/splash_screen.dart';

class CarShowroomApp extends StatelessWidget {
  const CarShowroomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Showroom',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
