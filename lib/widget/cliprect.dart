import 'package:flutter/material.dart';

import '../resources/constants/screen_responsive.dart';

class CustomCliprect extends StatelessWidget {
  final Size size;
  final String title;
  final String stat;
  final String subtitle;
  final String imagePath;
  final Function() onTap;
  final List<Color> gradientColors;
  final bool isBadgeBox;

  const CustomCliprect({
    super.key,
    required this.size,
    required this.title,
    required this.stat,
    required this.subtitle,
    required this.imagePath,
    required this.onTap,
    required this.gradientColors,
    this.isBadgeBox = false,
  });
  @override
  Widget build(BuildContext context) {
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    return GestureDetector(
      onTap: onTap,
      child: Builder(
        builder: (context) {
          final iconSize = (responsive.size.width * 0.07).clamp(24.0, 40.0);
          final fontScale = responsive.size.width / 375; // base width for scaling (iPhone X width)
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: size.width * 0.42,
              height: size.height * 0.17,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -size.width * 0.08,
                    right: -size.width * 0.08,
                    child: Container(
                      width: size.width * 0.25,
                      height: size.width * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -size.width * 0.05,
                    left: -size.width * 0.05,
                    child: Container(
                      width: size.width * 0.2,
                      height: size.width * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.04),
                    child: isBadgeBox
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Badges',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16 * fontScale,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 12 * fontScale,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Image.asset(
                              imagePath,
                              width: iconSize,
                              height: iconSize,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.012),
                        Text(
                          stat,
                          style: TextStyle(
                            fontSize: 15 * fontScale,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                       SizedBox(height: size.height * 0.007),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 6.5 * fontScale,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
