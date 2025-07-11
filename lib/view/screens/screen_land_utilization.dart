import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/cluster.dart';
import '../../controller/land_utilization_save.dart';
import '../../controller/plot_details.dart';
import '../../resources/constants/colours.dart';
import '../../resources/constants/screen_responsive.dart';
import '../../widget/app_bar.dart';
import '../../widget/bottom_navigation_bar.dart';
import '../../widget/side_menu.dart';
import '../../widget/toggle_direction.dart';
import 'land_utilization_table.dart';

class LandUtilization extends StatelessWidget {
  const LandUtilization({super.key});
  @override
  Widget build(BuildContext context) {
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    final DirectionController directionController = Get.put(
      DirectionController(),
    );
    final LandCategoryController landCategoryController = Get.put(
      LandCategoryController(),
    );
    final ClusterDetailController sidePlotController = Get.put(
      ClusterDetailController(),
    ); //
    final List<String> sidebarItems = [
      'Land Utilization',
      'KeyPlot Details',
      'Crop Details',
      'Irrigation Details',
    ];
    return Scaffold(
      backgroundColor: AppColour.whiteColour,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(responsive.screenHeight * 0.07),
        child: Builder(
          builder:
              (context) => CustomAppBar(
                onMenuTap: () => Scaffold.of(context).openDrawer(),
                hideLeading: false,
                title: Padding(
                  padding: EdgeInsets.only(top: responsive.screenHeight * .025),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'LAND UTILIZATION',
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
      drawer: CustomDrawer(
        sidebarItems: sidebarItems,
        width: responsive.screenWidth * 0.35,
        onItemTap: (index) {
          Navigator.pop(context); // Close the drawer
          switch (index) {
            case 0:
              Get.toNamed('/landUtilization');
              break;
            case 1:
              Get.toNamed('/keyplotOwner');

              break;
            case 2:
              Get.toNamed('/cropDetails');
              break;
            case 3:
              Get.toNamed('/irrigation');
              break;
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(child: DirectionSelectorToggle()),
            Expanded(
              child: Obx(() {
                final selected = directionController.selectedDirection.value;
                if (selected.isNotEmpty) {
                  final selectedDirection =
                      directionController.selectedDirection.value;
                  final totalAreaMap =
                      sidePlotController.data.value?.totalArea ?? {};
                  final area = totalAreaMap[selectedDirection] ?? 0.0;
                  final landController = Get.find<LandCategoryController>();
                  landController.setDirectionArea(area);
                  return LandUtilisationTable(direction: selected);
                } else {
                  return const SizedBox();
                }
              }),
            ),
            // GestureDetector(
            //   onTap: () async {
            //     final prefs = await SharedPreferences.getInstance();
            //     final userId= prefs.getString('userid') ?? '';
            //     final clusterID = prefs.getString('selectedClusterId') ?? '';
            //     final controller = Get.find<LandCategoryController>();
            //     final saveController = Get.put(LandUtilizationTableSave());
            //     final apiData = controller.getLandUtilizationDataForApi();
            //     final direction=directionController.selectedDirection.value;
            //     await saveController.saveLandUtilization(apiData, direction, clusterID,userId);
            //   },
            //   child: Container(
            //     height: 60,
            //     decoration: BoxDecoration(
            //       color: Colors.black,
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //     width: MediaQuery.of(context).size.width,
            //     child: const Center(
            //       child: Text(
            //         "Save",
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 18.0,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // GestureDetector(
                      //   onTap: () async {
                      //     final prefs = await SharedPreferences.getInstance();
                      //     final userId= prefs.getString('userid') ?? '';
                      //     final clusterID = prefs.getString('selectedClusterId') ?? '';
                      //     final controller = Get.find<LandCategoryController>();
                      //     final saveController = Get.put(LandUtilizationTableSave());
                      //     final apiData = controller.getLandUtilizationDataForApi();
                      //     await saveController.saveLandUtilization(apiData, direction, clusterID,userId);
                      //   },
                      //   child: Container(
                      //     height: 60,
                      //     decoration: BoxDecoration(
                      //       color: Colors.black,
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //     width: MediaQuery.of(context).size.width,
                      //     child: const Center(
                      //       child: Text(
                      //         "Save",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 18.0,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
          ],
        ),
      ),
     // bottomNavigationBar: const ResponsiveBottomNavBar(),
    );
  }
}
