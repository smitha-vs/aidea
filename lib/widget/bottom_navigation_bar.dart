import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/bottom_nav.dart';
import '../resources/constants/colours.dart';

class ResponsiveBottomNavBar extends StatelessWidget {
  const ResponsiveBottomNavBar({super.key});
  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return Obx(() {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.black, // Background color black
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), // Rounded top left
            topRight: Radius.circular(20), // Rounded top right
          ),
        ),
        child: ClipRRect(
          child: BottomNavigationBar(
            backgroundColor:  Colors.grey[700], // Important: also set backgroundColor here
            currentIndex: controller.selectedIndex.value,
            onTap: (index) => controller.changeIndex(index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColour.whiteColour,
            unselectedItemColor: AppColour.greyColour,
            iconSize: isTablet ? 30 : 24,
            selectedFontSize: isTablet ? 16 : 14,
            unselectedFontSize: isTablet ? 14 : 12,
          ),
        ),
      );
    });
  }
}