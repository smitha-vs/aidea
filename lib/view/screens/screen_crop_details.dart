import 'package:aidea/view/screens/test_crop_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cce_controller.dart';
import '../../controller/cluster.dart';
import '../../controller/crop_area_show.dart';
import '../../controller/crop_dropdown_menu.dart';
import '../../controller/crop_row_test.dart';
import '../../controller/plot_details.dart';
import '../../resources/constants/colours.dart';
import '../../resources/constants/screen_responsive.dart';
import '../../widget/app_bar.dart';
import '../../widget/bottom_navigation_bar.dart';
import '../../widget/cce_toggle_tab.dart';
import '../../widget/crop_area_show.dart';
import '../../widget/side_menu.dart';
import '../../widget/toggle_direction.dart';
import 'new_crop_page.dart';

class CropDetails extends StatelessWidget {
  CropDetails({super.key});
  final togController = Get.put(ToggleTabController());
  final ClusterDetailController sidePlotController = Get.put(
    ClusterDetailController(),
  );
  final LandCategoryController landCategoryController = Get.put(
    LandCategoryController(),
  );
  final MenuDropdownController menuDropdownController = Get.put(
    MenuDropdownController(),
  );
  final AreaController controller = Get.put(AreaController());
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final DirectionController directionController = Get.put(
      DirectionController(),
    );
    final CropControllers cropController = Get.put(CropControllers());
    final List<String> sidebarItems = [
      'Crop Details',
      'KeyPlot Details',
      'Irrigation Details',
      'Land Utilization',
    ];
    ever(directionController.selectedDirection, (_) {
      cropController.clearCropRows();
    });
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
                          text: 'CROP DATA',
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
              Get.toNamed('/cropDetails');
              break;
            case 1:
              Get.toNamed('/keyplotOwner');
              break;
            case 2:
              Get.toNamed('/irrigation');
              break;
            case 3:
              Get.toNamed('/landUtilization');
              break;
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DirectionSelectorToggle(),
            const SizedBox(height: 10),
            CropDropdownForm(),
            SizedBox(height: 10),
            const SizedBox(height: 5),
            Expanded(
              child: Obx(() {
                final selected = directionController.selectedDirection.value;
                return selected.isNotEmpty
                    ? CropTablePages(direction: selected)
                    : const SizedBox();
              }),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: const ResponsiveBottomNavBar(),
    );
  }
}
