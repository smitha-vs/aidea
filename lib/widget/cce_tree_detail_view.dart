import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cce_controller.dart';
import '../resources/constants/screen_responsive.dart';
import '../widget/text_field.dart';

class TreeDetailView extends StatelessWidget {
  const TreeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TreeController());
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 2,
            child: Text(
              "No of Trees",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildField("B", controller.bigController, Colors.tealAccent, controller.calculateTotal),
                _buildField("S", controller.smallController, Colors.lightBlueAccent, controller.calculateTotal),
                Obx(() => _readonlyField("Total", controller.total.value, Colors.amber.shade100)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(
      String label, TextEditingController controller, Color color, Function onChangedFn) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          width: 50,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            onChanged: (_) => onChangedFn(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _readonlyField(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          width: 50,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}