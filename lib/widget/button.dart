import 'package:flutter/material.dart';

import '../resources/constants/screen_responsive.dart';

class MyButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  final String? txt;
  final VoidCallback? onTap;
  const MyButton({super.key, this.height, this.width, this.radius, this.color, this.txt, this.onTap});

  @override
  Widget build(BuildContext context) {
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    return
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: responsive.screenWidth *.5,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12)),
          child: Center(child: Text(txt.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
        ),
      );
  }
}