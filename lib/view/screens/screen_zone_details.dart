import 'package:aidea/view/screens/screen_cce.dart';
import 'package:aidea/view/screens/screen_cluster_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/side_menu.dart';
import '../../controller/zone_controller.dart';
import '../../resources/constants/screen_responsive.dart';
import '../../widget/app_bar.dart';
import '../../widget/side_menu.dart';
import '../../widget/zone_info_card.dart';
import '../../widget/zone_plot_card.dart';

class ZoneDetailsPage extends StatelessWidget {
  final ZoneController controller = Get.put(ZoneController());
  final SidebarController sidebarController = Get.put(SidebarController());
  ZoneDetailsPage({super.key});
  final List<String> sidebarItems = [
    'Zone Details',
    'Cluster',
    'CCE',
    'Reports',
  ];
  final List<Widget> sidebarContents = [
    ClusterViewPage(),
    ScreenCCE(),
    //const IrrigationDetails(),
  ];
  @override
  Widget build(BuildContext context) {
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(responsive.screenHeight * 0.07),
        child: Builder(
          builder:
              (context) => CustomAppBar(
                onMenuTap: () => Scaffold.of(context).openDrawer(),
                hideLeading: true,
                title: Padding(
                  padding: EdgeInsets.only(top: responsive.screenHeight * .025),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'ZONE DETAILS',
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final plotData = controller.data.value?.payload.data ?? [];
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ZoneInfoCard(maxWidth: 600),
                const SizedBox(height: 20),
                if (plotData.isEmpty)
                  const Center(child: Text("No data available"))
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: plotData.length,
                    itemBuilder: (context, index) {
                      final item = plotData[index];
                      return PlotInfoCard(dataList: [
                        {
                          "Panchayath Name": item.pName,
                          "Village": item.villages.isNotEmpty ? item.villages.join(", ") : "N/A",
                          "Block": item.blocks.isNotEmpty ? item.blocks.join(", ") : "N/A",
                          "Wet Area": item.wetArea.toString(),
                          "Dry Area": item.dryArea.toString(),
                          "Total Area": item.totalArea.toString(),
                          "Wet Plots": item.wetPlot.toString(),
                          "Dry Plots": item.dryPlot.toString(),
                          "Total Plots": item.tPlot.toString(),
                        }
                      ]);
                    },
                  ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        );
      }),

    );
  }
}
