import 'package:flutter/material.dart';

import '../resources/constants/screen_responsive.dart';

class ProgressBox extends StatelessWidget {
  final String title;
  final List<Color> gradientColors;
  const ProgressBox({
    super.key,
    this.title = 'AIDEA',
    required this.gradientColors,
  });
  @override
  Widget build(BuildContext context) {
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: responsive.size.height * 0.25,
        width: responsive.size.width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: gradientColors,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
