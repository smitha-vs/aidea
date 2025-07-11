import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/irrigation_details_save.dart';
import '../../model/source_list.dart';
import '../../resources/constants/colours.dart';
import '../../resources/constants/screen_responsive.dart';
import '../../widget/app_bar.dart';
import '../../widget/bottom_navigation_bar.dart';
import '../../widget/side_menu.dart';

class IrrigationDetails extends StatelessWidget {
  const IrrigationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration(String hint) {
      return InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        hintStyle: const TextStyle(color: Colors.grey),
      );
    }

    final List<String> sidebarItems = [
      'Irrigation Details',
      'KeyPlot Details',
      'Crop Details',
      'Land Utilization',
    ];
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    final IrrigationDetailsSave menuController = Get.put(IrrigationDetailsSave());

    return Scaffold(
      backgroundColor: AppColour.whiteColour,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(responsive.screenHeight * 0.07),
        child: Builder(
          builder: (context) => CustomAppBar(
            onMenuTap: () => Scaffold.of(context).openDrawer(),
            hideLeading: false,
            title: Padding(
              padding: EdgeInsets.only(top: responsive.screenHeight * .025),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'IRRIGATION DETAILS',
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
              Get.toNamed('/irrigation');
              break;
            case 1:
              Get.toNamed('/keyplotOwner');
              break;
            case 2:
              Get.toNamed('/cropDetails');
              break;
            case 3:
              Get.toNamed('/landUtilization');
              break;
          }
        },
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Expanded(
                          flex: 2,
                          child: Text('Source',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 2,
                          child: Text('Area (in cents)',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...List.generate(menuController.irrigationEntries.length, (index) {
                    final entry = menuController.irrigationEntries[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: [
                          // Dropdown for Source
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              decoration: inputDecoration('Select'),
                              value: entry.selectedSource?.irrigationType,
                              items: menuController.getAvailableSourceForDropdown()
                                  .map((IriSources source) =>
                                  DropdownMenuItem<String>(
                                    value: source.irrigationType,
                                    child: Text(
                                      source.irrigationType,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                                  .toList(),
                              onChanged: (String? newValue) {
                                final selected = menuController
                                    .getAvailableSourceForDropdown()
                                    .firstWhere(
                                      (item) =>
                                  item.irrigationType == newValue,
                                );
                                entry.selectedSource = selected;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: entry.areaController,
                              keyboardType: TextInputType.number,
                              decoration: inputDecoration('Area'),
                              onChanged: (value) {
                                // Validation: Don't allow entry without source
                                if (entry.selectedSource == null &&
                                    value.trim().isNotEmpty) {
                                  Get.snackbar(
                                    'Missing Source',
                                    'Please select source before entering area.',
                                    backgroundColor: Colors.orange.shade100,
                                    colorText: Colors.black,
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: const Duration(seconds: 3),
                                  );
                                  entry.areaController.clear();
                                } else {
                                  // Recalculate gross area
                                  double sum = 0;
                                  for (var e in menuController.irrigationEntries) {
                                    if (e.selectedSource != null &&
                                        e.areaController.text.isNotEmpty) {
                                      final val = double.tryParse(
                                          e.areaController.text) ??
                                          0.0;
                                      sum += val;
                                    }
                                  }
                                  menuController.grossAreaFromAPI.value =
                                      sum.toStringAsFixed(2);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  TextButton.icon(
                    onPressed: () {
                      menuController.addIrrigationEntry();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Source'),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Text('Gross Area Irrigated: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Obx(() => Text(menuController.grossAreaFromAPI.value)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final clusterID =
                          prefs.getString('selectedClusterId') ?? '';
                      menuController.saveIrrigationDetails(
                        menuController.grossAreaFromAPI.value,
                        menuController.netArea.text,
                        clusterID,
                      );
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
              ),
            ),
          );
        }),
      ),
     // bottomNavigationBar: const ResponsiveBottomNavBar(),
    );
  }
}
