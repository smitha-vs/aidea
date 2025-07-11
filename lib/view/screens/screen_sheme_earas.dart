import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/side_menu.dart';
import '../../resources/constants/colours.dart';
import '../../resources/constants/screen_responsive.dart';
import '../../widget/app_bar.dart';
import '../../widget/bottom_navigation_bar.dart';
import '../../widget/cliprect.dart';
import '../../widget/side_menu.dart';
class ScreenEarasExt extends StatelessWidget {
  const ScreenEarasExt({super.key});
  @override
  Widget build(BuildContext context) {
    List<List<Color>> gradientList = [
      [ const Color(0xFFfc6076),  const Color(0xFFff9a44,)],
      [Color(0xFF4481eb), Color(0xFF04befe)],// pinkish
      [const Color(0xFF6BBBFF), const Color(0xFF65379B)],
      [const Color(0xFFed6ea0), const Color(0xFFec8c69)], // violet to pink
      [const Color(0xFFc471f5), const Color(0xFFfa71cd)], // aqua blue
      [
        const Color(0xFF0ba342),
        const Color(0xFF43e97b)
      ], // soft pastel pink to cyan
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
                        text: 'EARAS',
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
                      title: 'EARAS',
                      stat: 'Zone Details',
                      subtitle: '',
                      imagePath: 'assets/icons/zone_details.png',
                      onTap: () {
                        Get.toNamed('/zoneDetailPage');
                      },
                      gradientColors: gradientList[0],
                    ),
                    CustomCliprect(
                      size: responsive.size,
                      title: 'EARAS',
                      stat: 'Cluster',
                      subtitle: '',
                      imagePath: 'assets/icons/cluster.png',
                      onTap: () {
                        Get.toNamed('/clusterScreen');
                      },
                      gradientColors: gradientList[2],
                    ),
                    CustomCliprect(
                      size: responsive.size,
                      title: 'EARAS',
                      stat: 'CCE',
                      subtitle: '',
                      imagePath: 'assets/icons/wheat.png',
                      onTap: () {
                        Get.toNamed('/ccedashboard');
                      },
                      gradientColors: gradientList[3],
                    ),
                    CustomCliprect(
                      size: responsive.size,
                      title: 'EARAS',
                      stat: 'Reports',
                      subtitle: '',
                      imagePath: 'assets/icons/business-report.png',
                      onTap: () {},
                      gradientColors: gradientList[4],
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
