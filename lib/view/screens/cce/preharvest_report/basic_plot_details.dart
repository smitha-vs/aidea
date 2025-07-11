import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../resources/constants/colours.dart';
import '../../../../resources/constants/screen_responsive.dart';
import '../../../../widget/app_bar.dart';
import '../../../../widget/bottom_navigation_bar.dart';
import '../../../../widget/button.dart';
import '../../../../widget/side_menu.dart';
import '../../../../widget/text_field.dart';
class BasicPlotDetails extends StatelessWidget {
  const BasicPlotDetails({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> sidebarItems = [
      'BasicPlot Details',
      'Land & Farmer',
      'Cultivation Details',
    ];
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    return  Scaffold(
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
                      text: 'BASIC PLOT DETAILS',
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
            child:
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20.0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('District',textAlign:TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5.0),
                  MyTextField(txt: '', hintText: 'District', obscureText: false,width: responsive.screenWidth*0.8),
                  const SizedBox(height: 20.0),
                  const Text('Taluk',textAlign:TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5.0),
                  MyTextField(txt: '', hintText: 'Taluk', obscureText: false,width: responsive.screenWidth*0.8),
                  const SizedBox(height: 20.0),
                  const Text('Local Type',textAlign:TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5.0),
                  MyTextField(txt: '', hintText: 'Local Type', obscureText: false,width: responsive.screenWidth*0.8,
                  //  controller: kpSaveController.addressController,
                  ),
                  const SizedBox(height: 20.0),
                  const Text('Zone ID',textAlign:TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold),),
                  MyTextField(txt: '', hintText: 'Zone ID', obscureText: false,width: responsive.screenWidth*0.8,
                    //  controller: kpSaveController.addressController,
                  ),
                  const SizedBox(height: 20.0),
                  const Text('Agricultural Year',textAlign:TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5.0),
                  MyTextField(txt: '', hintText: 'Agricultural Year', obscureText: false,width: responsive.screenWidth*0.8,
                    //  controller: kpSaveController.addressController,
                  ),
                  SizedBox(height: responsive.screenHeight *0.10),
                  Center(
                    child: MyButton(
                        color: AppColour.desBlueColor,
                        radius: 0,
                        txt: 'SAVE',
                        height: 47,
                        width: 200,
                        onTap: () async {
                          // if (kpSaveController.nameController.text.trim().isEmpty &&
                          //     kpSaveController.phoneController.text.trim().isEmpty &&
                          //     kpSaveController.addressController.text.trim().isEmpty) {
                          //   Get.snackbar(
                          //     'Empty Fields',
                          //     'Please enter at least one field before saving.',
                          //     backgroundColor: Colors.orange.shade100,
                          //     colorText: Colors.black,
                          //     snackPosition: SnackPosition.BOTTOM,
                          //   );
                          //   return;
                          // }
                          // final prefs = await SharedPreferences.getInstance();
                          // final clusterID = prefs.getString('selectedClusterId') ?? '';
                          // kpSaveController.saveKeyPlotDetails(
                          //   kpSaveController.nameController.text,
                          //   kpSaveController.phoneController.text,
                          //   kpSaveController.addressController.text,
                          //   clusterID,
                          // );
                        }
                    ),
                  )
                ],
              ),
            )),
      ),
      bottomNavigationBar:  const ResponsiveBottomNavBar(),
    );
  }
}
