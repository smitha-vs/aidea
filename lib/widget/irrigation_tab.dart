import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/irrigation_tab.dart';


class IrrigationTabWidget extends StatelessWidget {
  final Widget irrigatedContent;
  final Widget unirrigatedContent;

  IrrigationTabWidget({
    super.key,
    required this.irrigatedContent,
    required this.unirrigatedContent,
  });

  final IrrigationTabController controller = Get.put(IrrigationTabController());

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          controller: controller.tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: const [
            Tab(text: 'Irrigated'),
            Tab(text: 'Unirrigated'),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: isWide ? 300 : 250,
          child: TabBarView(
            controller: controller.tabController,
            children: [
              irrigatedContent,
              unirrigatedContent,
            ],
          ),
        ),
      ],
    );
  }
}
