import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/plot_details.dart';
import '../resources/constants/colours.dart';

class DirectionSelector extends StatelessWidget {
  final List<String> directions = ['Keyplot', 'East', 'West', 'North', 'South'];
  DirectionSelector({super.key});
  @override
  Widget build(BuildContext context) {
    final DirectionController controller = Get.find<DirectionController>();
    final screenWidth = MediaQuery.of(context).size.width;
    return Obx(() {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 10,
        children: directions.map((direction) {
          final bool isSelected = controller.selectedDirection.value == direction;
          return GestureDetector(
            onTap: () {
              controller.setDirection(direction);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected ? AppColour.desBlueColor : Colors.grey,
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: AppColour.desBlueColor.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
                    : [],
              ),
              child: Text(
                direction,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}
