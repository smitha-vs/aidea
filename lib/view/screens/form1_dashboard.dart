import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controller/cluster.dart';
import '../../model/cluster_grid.dart';
import '../../resources/constants/colours.dart';
import '../../resources/constants/screen_responsive.dart';
import '../../widget/app_bar.dart';
import '../../widget/bottom_navigation_bar.dart';
import '../../widget/cliprect.dart';
import '../../widget/side_menu.dart';

class Form1Dashboard extends StatelessWidget {
  const Form1Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    List<List<Color>> gradientList = [
      [ const Color(0xFFFFE29F),const Color(0xFFFFA99F),  const Color(0xFFFF719A,)],
      [Color(0xFF5D9FFF), Color(0xFFB8DCFF),Color(0xFF6BBBFF)],// pinkish
      [const Color(0xFFB7F8DB), const Color(0xFF50A7C2)],
      [const Color(0xFF65379B), const Color(0xFF886AEA), const Color(0xFF6457C6)], // violet to pink
      [const Color(0xFFc471f5), const Color(0xFFfa71cd)], // aqua blue
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
                        text: 'FORM 1',
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
                      title: 'Form 1',
                      stat: 'Key Plot Details',
                      subtitle: '',
                      imagePath: 'assets/icons/keyplot.png',
                      onTap: () {
                        Get.toNamed(
                          '/keyplotOwner',
                        );
                      },
                      gradientColors: gradientList[0],
                    ),
                    CustomCliprect(
                      size: responsive.size,
                      title: 'Form 1',
                      stat: 'Crop Details',
                      subtitle: '',
                      imagePath: 'assets/icons/wheat.png',
                      onTap: () {
                        Get.toNamed('/cropDetails');
                      },
                      gradientColors: gradientList[1],
                    ),
                    CustomCliprect(
                      size: responsive.size,
                      title: 'Form 1',
                      stat: 'Irrigation Details',
                      subtitle: '',
                      imagePath: 'assets/icons/irrigation.png',
                      onTap: () {
                        Get.toNamed('/irrigation');
                        },
                      gradientColors: gradientList[2],
                    ),
                    CustomCliprect(
                      size: responsive.size,
                      title: 'Form 1',
                      stat: 'Land Utilization',
                      subtitle: '',
                      imagePath: 'assets/icons/field.png',
                      onTap: () {
                        Get.toNamed('/landUtilization');
                      },
                      gradientColors: gradientList[3],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
