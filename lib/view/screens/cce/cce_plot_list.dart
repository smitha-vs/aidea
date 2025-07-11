import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/cce/cce_plot.dart';
import '../../../resources/constants/screen_responsive.dart';
import '../../../widget/app_bar.dart';

class CcePlotList extends StatelessWidget {
  const CcePlotList({super.key});

  @override
  Widget build(BuildContext context) {
    final CcePlotController controller = Get.put(CcePlotController());
    final ResponsiveHelper responsive = ResponsiveHelper(context);

    return Scaffold(
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
                      text: 'AVAILABLE PLOTS',
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
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.availablePlot.isEmpty) {
            return const Center(child: Text('No available plots found.'));
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Plot ID')),
                      DataColumn(label: Text('Cluster ID')),
                      DataColumn(label: Text('Crop ID')), // Replace with Crop Name if mapping is available
                      DataColumn(label: Text('Source Type')),
                    ],
                    rows: controller.availablePlot.map((crop) {
                      return DataRow(cells: [
                        DataCell(Text(crop.plotId)),
                        DataCell(Text(crop.clusterId.toString())),
                        DataCell(Text(crop.cropId.toString())), // Replace with name if needed
                        DataCell(Text(crop.cceSourceType)),
                      ]);
                    }).toList(),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
