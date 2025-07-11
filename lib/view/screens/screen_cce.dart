import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cce_controller.dart';
import '../../resources/constants/screen_responsive.dart';
import '../../widget/app_bar.dart';
import '../../widget/cce_land_details_view.dart';
import '../../widget/cce_tab_category.dart';
import '../../widget/cce_toggle_tab.dart';
import '../../widget/crop_cce_view.dart';
import '../../widget/irrigation_cce_view.dart';
import '../../widget/yield_cce_view.dart';

class ScreenCCE extends StatelessWidget {
  const ScreenCCE({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    final controller = Get.put(CategoryTabController());
    final togController = Get.put(ToggleTabController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(responsive.screenHeight * 0.07),
        child: Builder(
          builder:
              (context) => CustomAppBar(
                onMenuTap: () => Scaffold.of(context).openDrawer(),
                title: Padding(
                  padding: EdgeInsets.only(top: responsive.screenHeight * .025),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'CCE',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const ToggleTabSwitch(),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                return togController.selectedIndex.value == 0
                    ? Column(
                      children: [
                        const CategoryTabBar(), // Your TabBar
                        const SizedBox(height: 10),
                        Expanded(
                          child: TabBarView(
                            controller: controller.tabController,
                            children: const [
                              LandCCEView(),
                              CropCCEView(),
                              IrrigationCCEView(),
                              YieldCCEView(),
                            ],

                          ),
                        ),
                      ],
                    )
                    : const Center(
                      child: Text('CCE-2 View', style: TextStyle(fontSize: 20)),
                    );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
