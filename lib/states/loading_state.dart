import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subtitle;

  const LoadingState(
      {super.key,
      required this.iconData,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Loading animation
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(26),
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                color: Colors.white.withAlpha(179),
                size: 30,
              ),
            ),
            SizedBox(height: 24),

            // Loading text
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),

            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withAlpha(179),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
