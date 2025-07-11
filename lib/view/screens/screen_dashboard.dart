import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resources/constants/colours.dart';
import '../../resources/constants/screen_responsive.dart';
import '../../widget/app_bar.dart';
import '../../widget/bottom_navigation_bar.dart';
import '../../widget/cliprect.dart';
import '../../widget/progress_bar.dart';
import '../../widget/side_menu.dart';
class ScreenDashboard  extends StatelessWidget {
 const ScreenDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    List<List<Color>> gradientList = [
      [const Color(0xFFff0844), const Color(0xFFffb199)], // pinkish
      [const Color(0xFF6f86d6), const Color(0xFF48c6ef)], // violet to pink
      [const Color(0xFFc471f5), const Color(0xFFfa71cd)], // aqua blue
      [const Color(0xFF0ba360), const Color(0xFF3cba92)], // soft pastel pink to cyan
    ];
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    final List<String> sidebarItems = [
      'Profile',
      'Notifications',
      'Logout',
    ];
    return Scaffold(
        backgroundColor: AppColour.whiteColour,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(responsive.screenHeight * 0.07),
          child: Builder(
            builder: (context) => CustomAppBar(
              onMenuTap: () => Scaffold.of(context).openDrawer(),
              hideLeading: true,
              title:
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'DASHBOARD',
                      style: TextStyle(
                        fontSize: responsive.screenWidth * 0.05,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        drawer:CustomDrawer(sidebarItems: sidebarItems, width:responsive.screenWidth * 0.35),
        body:
        SingleChildScrollView(
          child: 
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20.0),
                    child: ProgressBox(title: 'AIDEA', gradientColors: [Color(0xFF0074B7),Color(0xFF9DD6F0)],) // or pass a custom title,
                ),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    CustomCliprect(size: responsive.size, title:  'AIDEA', stat: 'Schemes', subtitle: 'The DES deals with data collection...', imagePath:  'assets/icons/implement.png', onTap: () {
                      Get.toNamed('/earasScreen');
                    }, gradientColors:  gradientList[0],),
                    CustomCliprect(size: responsive.size, title: 'AIDEA', stat: 'Reports', subtitle: 'View/download progress reports', imagePath:   'assets/icons/monitor_report.png', onTap: () {
                    }, gradientColors:  gradientList[1],),
                    CustomCliprect(size: responsive.size, title:'AIDEA', stat:'Approvals', subtitle: 'Verification & Approvals', imagePath:'assets/icons/approved.png', onTap: () {
                    }, gradientColors:  gradientList[2],),
                    CustomCliprect(size: responsive.size, title: 'AIDEA', stat:  'Tour Diary', subtitle:  'The daily activity of the users', imagePath: 'assets/icons/diary.png', onTap: () {
                    }, gradientColors:  gradientList[3],),
                  ],
                ),
            
              ],),
          ),
        ),
        bottomNavigationBar:  const ResponsiveBottomNavBar()
    );
  }
}