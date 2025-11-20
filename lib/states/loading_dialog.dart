import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:piehme_cup_flutter/constants/app_colors.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(40),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.grey[900]!.withAlpha(242),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.brand.withAlpha(77),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(128),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lottie Animation
            SizedBox(
              width: 230,
              height: 150,
              child: Lottie.asset(
                'assets/lottie/map-search.json',
                fit: BoxFit.contain,
              ),
            ),

            // Loading Text
            Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              'Please wait while processing data.',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Progress Indicator
            SizedBox(
              width: 100,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.shade800,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.brand,
                ),
                borderRadius: BorderRadius.circular(10),
                minHeight: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}