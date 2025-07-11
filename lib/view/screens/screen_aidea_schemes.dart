import 'package:aidea/view/screens/working%20login.dart';
import 'package:flutter/material.dart';

import '../../resources/constants/colours.dart';
import '../../resources/constants/screen_responsive.dart';
import '../../widget/app_bar.dart';
import '../../widget/bottom_navigation_bar.dart';
import '../../widget/cliprect.dart';
import '../../widget/grid_item.dart';
import '../../widget/side_menu.dart';
class ScreenSchemesExt extends StatelessWidget {
  const ScreenSchemesExt({super.key});
  @override
  Widget build(BuildContext context) {
    List<List<Color>> gradientList = [
      [const Color(0xFFff0844), const Color(0xFFffb199)],
      [const Color(0xFFfc6076), const Color(0xFFff9a44)], // pinkish
      [const Color(0xFF4481eb), const Color(0xFF04befe)], // violet to pink
      [const Color(0xFF0c3483), const Color(0xFFa2b6df)], // aqua blue
      [const Color(0xFFFFD194), const Color(0xFFD1913C)],
      [const Color(0xFFFDC830), const Color(0xFFF37335),], //
      [const Color(0xFF654ea3), const Color(0xFFeaafc8,)], // pinkish
      [const Color(0xFF00B4DB), const Color(0xFF0083B0)], // aqua blue
      [const Color(0xFF636363), const Color(0xFFa2ab58)],
      [const Color(0xFFff0844), const Color(0xFFffb199)], // soft pastel pink to cyan
    ];
      final ResponsiveHelper responsive = ResponsiveHelper(context);
      final List<String> sidebarItems = [
        'Work Allocation Report',
        'Cluster Formation',
        'Crop Cutting Experiment',
        'Profile',
        'Settings',
      ];
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
                        text: 'SCHEMES',
                        //   '${sidebarItems[controller.activeIndex.value]} ',
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
        drawer: CustomDrawer(sidebarItems: sidebarItems, width:responsive.screenWidth * 0.35),
        body:
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20.0),
            child:DashboardPage(),
        ),
        bottomNavigationBar:  const ResponsiveBottomNavBar(),
      );
    }
  }

