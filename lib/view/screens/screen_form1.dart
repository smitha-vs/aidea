import 'package:aidea/view/screens/screen_crop_details.dart';
import 'package:aidea/view/screens/screen_irrigation.dart';
import 'package:aidea/view/screens/screen_keyplot_details.dart';
import 'package:aidea/view/screens/screen_land_utilization.dart';
import 'package:aidea/view/screens/screen_nfs_css.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/side_menu.dart';
import '../../resources/constants/screen_responsive.dart';
import '../../widget/app_bar.dart';
import '../../widget/side_menu.dart';
class Form1 extends StatelessWidget {
  const Form1({super.key});
  @override
  Widget build(BuildContext context) {
    final SidebarController controller = Get.put(SidebarController());
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    final String clusterName = Get.arguments?['clusterNumber'] ?? 'Unknown Cluster';
    final List<String> sidebarItems = [
      'Key Plot Details',
      'Land Utilization',
      'Crop Data',
      'Irrigation Details',
      'NUC'
    ];
    final List<Widget> sidebarContents = [
      const KeyPlotOwner(),
      const LandUtilization(),
      CropDetails(),
      const IrrigationDetails(),
      NFSValue()
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(responsive.screenHeight * 0.07),
        child: Builder(
          builder: (context) => CustomAppBar(
            onMenuTap: () => Scaffold.of(context).openDrawer(),
            title: Obx(() => Padding(
              padding: EdgeInsets.only(top: responsive.screenHeight * .025),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '(C$clusterName)',
                      style: TextStyle(
                        fontSize: responsive.screenWidth * 0.03,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ),
        ),
      ),
      drawer:CustomDrawer(sidebarItems: sidebarItems, width: responsive.screenWidth * 0.35),
      body: Obx(() =>
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20.0),
            child: Container(
              child: sidebarContents[controller.activeIndex.value],
            ),
          )),
    );
  }
}