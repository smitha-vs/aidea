import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/constants/colours.dart';
import '../../../../resources/constants/screen_responsive.dart';
import '../../../../widget/app_bar.dart';
import '../../../../widget/bottom_navigation_bar.dart';
import '../../../../widget/cliprect.dart';
class PreharvestDashboard extends StatelessWidget {
  const PreharvestDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    List<List<Color>> gradientList = [
      [ const Color(0xFFfe8dc6),const Color(0xFFfed1c7),],
      [Color(0xFFff00d4), Color(0xFF00ddff)],// pinkish
      [const Color(0xFFfbb040 ), const Color(0xFFf9ed32)],
      [const Color(0xFF00a1ff), const Color(0xFF00ff8f)], // violet to pink
      [const Color(0xFFee2a7b), const Color(0xFFf77db8)], // aqua blue
      [const Color(0xFF0ba342), const Color(0xFF43e97b)], // soft pastel pink to cyan
    ];
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    return Scaffold(
        backgroundColor: AppColour.whiteColour,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(responsive.screenHeight * 0.07),
          child: Builder(
            builder: (context) => CustomAppBar(
              onMenuTap: () => Scaffold.of(context).openDrawer(),
              hideLeading: true,
              title: Padding(
                padding: EdgeInsets.only(top: responsive.screenHeight * .025),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Preharvest Report',
                        style: TextStyle(
                          fontSize: responsive.screenWidth * 0.045,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20.0),
                child:Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    CustomCliprect(
                      size: responsive.size,
                      title: 'Preharvest',
                      stat: 'Basic Plot details',
                      subtitle: '',
                      imagePath: 'assets/icons/keyplot.png',
                      onTap: () {
                        Get.toNamed(
                          '/cceBasicPlot',
                        );
                      },
                      gradientColors: gradientList[0],
                    ),
                    CustomCliprect(
                      size: responsive.size,
                      title: 'Preharvest',
                      stat: 'Land & Farmer',
                      subtitle: '',
                      imagePath: 'assets/icons/wheat.png',
                      onTap: () {
                        Get.toNamed('/cceLandFarmer');
                      },
                      gradientColors: gradientList[1],
                    ),
                    CustomCliprect(
                      size: responsive.size,
                      title: 'Preharvest',
                      stat: 'Cultivation Details',
                      subtitle: '',
                      imagePath: 'assets/icons/irrigation.png',
                      onTap: () {
                        Get.toNamed('/phcultivation');
                      },
                      gradientColors: gradientList[2],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const ResponsiveBottomNavBar());
  }
}

