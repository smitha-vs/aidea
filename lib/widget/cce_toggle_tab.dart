import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cce_controller.dart';
class ToggleTabSwitch extends GetView<ToggleTabController> {
  final List<String> irrigated;
  const ToggleTabSwitch({
    super.key,
    this.irrigated = const ['Irrigated', 'NonIrrigated'],
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(irrigated.length, (index) {
          return Expanded(
            child: Obx(() {
              final isSelected = controller.selectedIndex.value == index;
              return GestureDetector(
                onTap: () => controller.selectTab(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                      colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
                    )
                        : null,
                    color: isSelected ? null : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      irrigated[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
