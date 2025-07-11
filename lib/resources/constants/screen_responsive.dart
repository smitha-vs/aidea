import 'package:flutter/material.dart';

class ResponsiveHelper {
  final BuildContext context;
  late double screenWidth;
  late double screenHeight;
  late double cardHeight;
  late double iconSize;
  late double textSize;

  ResponsiveHelper(this.context) {
    final size = MediaQuery.of(context).size;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    cardHeight = screenHeight * 0.10; // 10% of screen height
    iconSize = screenWidth * 0.08; // 8% of screen width
    textSize = screenWidth * 0.035; // 3.5% of screen width
  }
  Size get size => MediaQuery.of(context).size;
}