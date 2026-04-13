import 'dart:math';

import 'package:car_showroom_app/core/constants/app_assets.dart';
import 'package:car_showroom_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Temporary root after splash until real home flow is defined.
class RootPlaceholderScreen extends StatelessWidget {
  const RootPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Stack(
        children: [
          Center(
            child: Image.asset(AppAssets.onboardImage3, height: 700,),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(.13),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(.2),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Image.asset(AppAssets.steering, width: 30,height: 30,),
                    ),
                    Text("Get Started", style: AppTextStyles.splashSubtitle.copyWith(fontSize: 16, fontWeight: FontWeight.w700),),
                    Image.asset(AppAssets.arrow, width: 30,height: 30,),
                ]
                ),
              ))
        ],
      ),
    );
  }
}
