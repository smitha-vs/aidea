import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/plot_details.dart';
import '../view/screens/screen_crop_details.dart';

class CropDirectionSelect extends StatelessWidget {
  const CropDirectionSelect({super.key});
 // for example

  final List<String> directions = const ['K', 'E', 'N', 'W', 'S'];
  String getFullLabel(String short) {
    switch (short) {
      case 'K':
        return 'K';
      case 'E':
        return 'E';
      case 'N':
        return 'N';
      case 'W':
        return 'W';
      case 'S':
        return 'S';
      default:
        return '';
    }
  }
  @override
  Widget build(BuildContext context) {
    final DirectionController controller = Get.put(DirectionController());
    double width = MediaQuery.of(context).size.width;
    double iconSize = width * 0.07;
    double fontSize = width * 0.045;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: directions.map((dir) {
          return buildDirectionItem(controller, dir, iconSize, fontSize);
        }).toList(),
      )),
    );
  }
  Widget buildDirectionItem(
      DirectionController controller,
      String label,
      double iconSize,
      double fontSize,
      ) {
    bool isSelected = controller.selectedDirection.value == label;
    String fullLabel = getFullLabel(label);
    return GestureDetector(
      onTap: () {
        controller.updateDirection(label);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[100] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.blue.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 4),
            Text(
              fullLabel,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.blue[900] : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
