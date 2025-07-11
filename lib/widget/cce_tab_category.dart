import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cce_controller.dart';
class CategoryTabBar extends StatelessWidget {
  const   CategoryTabBar({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryTabController>();
    return TabBar(
      controller: controller.tabController,
      isScrollable: true,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.orange,
      indicatorWeight: 3,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      tabs: controller.tabs.map((e) => Tab(text: e)).toList(),
    );
  }
}
