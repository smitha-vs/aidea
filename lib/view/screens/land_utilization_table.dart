import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/land_utilization_save.dart';
import '../../controller/plot_details.dart';
import '../../resources/constants/screen_responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LandUtilisationTable extends StatelessWidget {
  final String direction;
  const LandUtilisationTable({super.key, required this.direction});
  @override
  Widget build(BuildContext context) {
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    final LandCategoryController controller = Get.put(LandCategoryController());
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            final remaining = controller.remainingArea.value;
            if (remaining <= 0.5) {
              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  '⚠️ Only ${remaining.toStringAsFixed(2)} cents available to enter.',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return const SizedBox();
          }),
          SizedBox(height: 5,),
          Table(
            border: TableBorder.all(color: Colors.black),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                decoration: const BoxDecoration(color: Colors.black12),
                children: [
                  _headerCell(context, 'Category'),
                  _headerCell(context, 'Area (in cents)'),
                ],
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                border: TableBorder.all(color: Colors.black),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                },
                children: controller.categories.map((category) {
                  return TableRow(
                    children: [
                      _tableCell(context, category),
                      _areaInputFields(context, controller, category),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              final userId= prefs.getString('userid') ?? '';
              final clusterID = prefs.getString('selectedClusterId') ?? '';
              final controller = Get.find<LandCategoryController>();
              final saveController = Get.put(LandUtilizationTableSave());
              final apiData = controller.getLandUtilizationDataForApi();
              await saveController.saveLandUtilization(apiData, direction, clusterID,userId);
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
  }
  Widget _headerCell(BuildContext context, String text) {
    final responsive = ResponsiveHelper(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black54, Colors.black54],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.all(responsive.screenWidth * 0.02),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: responsive.screenWidth * 0.03,
          color: Colors.white,
        ),
      ),
    );
  }
  Widget _tableCell(BuildContext context, String text) {
    final responsive = ResponsiveHelper(context);
    final List<String> infoIconCategories = [
      'cultivable waste',
      'other fallow',
      'current fallow',
    ];
    final bool showInfoIcon = infoIconCategories.contains(text.toLowerCase().trim());
    return Padding(
      padding: EdgeInsets.all(responsive.screenWidth * 0.02),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: responsive.screenWidth * 0.035),
            ),
          ),
          if (showInfoIcon)
            IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.blue),
              onPressed: () => _showInfoPopup(context, text),
            ),
        ],
      ),
    );
  }
  Widget _areaInputFields(
      BuildContext context,
      LandCategoryController controller,
      String category,
      ) {
    final responsive = ResponsiveHelper(context);
    return Padding(
      padding: EdgeInsets.all(responsive.screenWidth * 0.02),
      child: Obx(() {
        final total = controller.totalValues[category]!.value;
        return Column(
          children: [
            TextField(
              controller: TextEditingController(text: total)
                ..selection = TextSelection.fromPosition(
                  TextPosition(offset: total.length),
                ),
              readOnly: true,
              decoration: const InputDecoration(labelText: 'Total Area'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.inputControllers[category],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Area',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => controller.addToTotal(category),
            ),
          ],
        );
      }),
    );
  }

  void _showInfoPopup(BuildContext context, String category) {
    final TextEditingController nucController = TextEditingController(text: '0.25');
    final TextEditingController ffsController = TextEditingController(text: '0.40');
    final TextEditingController cosController = TextEditingController(text: '0.35');
    final TextEditingController remarksController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        final responsive = ResponsiveHelper(context);
        return AlertDialog(
          title: Text('$category Details'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _infoField('NUC', nucController),
                const SizedBox(height: 10),
                _infoField('FFS', ffsController),
                const SizedBox(height: 10),
                _infoField('COS', cosController),
                const SizedBox(height: 10),
                TextField(
                  controller: remarksController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Remarks',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Handle save logic here
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _infoField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: '$label Area',
        border: const OutlineInputBorder(),
      ),
    );
  }
}