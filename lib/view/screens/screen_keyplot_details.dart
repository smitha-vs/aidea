import 'package:aidea/widget/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/keyplot_save.dart';
import '../../controller/side_menu.dart';
import '../../resources/constants/colours.dart';
import '../../resources/constants/screen_responsive.dart';
import '../../widget/app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
class KeyPlotOwner extends StatelessWidget {
  const KeyPlotOwner({super.key});
  @override
  Widget build(BuildContext context) {
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    final KeyplotSave kpSaveController = Get.put(KeyplotSave());
    final List<String> sidebarItems = [
      'KeyPlot Details',
      'Crop Details',
      'Irrigation Details',
      'Land Utilization',
    ];
    InputDecoration inputDecoration(String hint) {
      return InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        hintStyle: const TextStyle(color: Colors.grey),
      );
    }
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
                      text: 'KEYPLOT DETAILS',
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
              Get.toNamed('/keyplotOwner');
              break;
            case 1:
              Get.toNamed('/cropDetails');
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Name',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5.0),
                TextField(
                  controller: kpSaveController.nameController,
                  decoration: inputDecoration('Enter Name'),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Phone Number',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5.0),
                TextField(
                  controller: kpSaveController.phoneController,
                  decoration: inputDecoration('Enter Mobile Number'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Address',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5.0),
                TextField(
                  controller: kpSaveController.addressController,
                  decoration: inputDecoration('Enter Address'),
                  maxLines: 5,
                ),
                SizedBox(height: responsive.screenHeight * 0.10),
                GestureDetector(
                  onTap: () async {
                    if (kpSaveController.nameController.text.trim().isEmpty &&
                        kpSaveController.phoneController.text.trim().isEmpty &&
                        kpSaveController.addressController.text.trim().isEmpty) {
                      Get.snackbar(
                        'Empty Fields',
                        'Please enter at least one field before saving.',
                        backgroundColor: Colors.orange.shade100,
                        colorText: Colors.black,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }
                    final prefs = await SharedPreferences.getInstance();
                    final userId = prefs.getString('userid') ?? '';
                    final clusterID = prefs.getString('selectedClusterId') ?? '';
                    kpSaveController.saveKeyPlotDetails(
                      kpSaveController.nameController.text,
                      kpSaveController.phoneController.text,
                      kpSaveController.addressController.text,
                      clusterID,
                      userId,
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
        ),
      ),
     // bottomNavigationBar: const ResponsiveBottomNavBar(),
    );
  }
}
