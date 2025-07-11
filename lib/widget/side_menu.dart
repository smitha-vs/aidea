import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/side_menu.dart';
import '../resources/constants/sidebar_item.dart';

class CustomDrawer extends StatelessWidget {
  final List<String> sidebarItems;
  final double width;
  final Function(int)? onItemTap;
  const CustomDrawer({
    super.key,
    required this.sidebarItems,
    required this.width,
    this.onItemTap,
  });
  @override
  Widget build(BuildContext context) {
    final SidebarController controller = Get.put(SidebarController());
    return Drawer(
      child: Container(
        width: width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20.0),
          child: Obx(() => ListView(
            padding: EdgeInsets.zero,
            children: [
              ...List.generate(sidebarItems.length, (index) {
                return Column(
                  children: [
                    SidebarItem(
                      title: sidebarItems[index],
                      isActive: controller.activeIndex.value == index,
                      onTap: () {
                        onItemTap?.call(index);
                      },
                    ),
                    const Divider(),
                  ],
                );
              }),
            ],
          )),
        ),
      ),
    );
  }
}
