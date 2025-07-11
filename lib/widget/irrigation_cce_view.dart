import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cce_controller.dart';
import 'my_dropdown.dart';
class IrrigationCCEView extends StatelessWidget {
  const IrrigationCCEView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IrrigationController());
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow(
            label: "Irrigation Method",
            widget: MyDropdown(
              label: '',
              items: ['Drip', 'Sprinkler', 'Flood', 'Manual'],
             selectedValue: controller.irrigationMethod,
              width: MediaQuery.of(context).size.width * 0.6,
            ),
          ),
          const SizedBox(height: 12),
          _buildRow(
            label: "Fertilizer",
            widget: Obx(() => _yesNoToggle(
              value: controller.fertilizerUsed.value,
              onYes: () => controller.fertilizerUsed.value = true,
              onNo: () => controller.fertilizerUsed.value = false,
            )),
          ),
          const SizedBox(height: 12),
          _buildRow(
            label: "Plant infected",
            widget: Obx(() => _yesNoToggle(
              value: controller.infected.value,
              onYes: () => controller.infected.value = true,
              onNo: () => controller.infected.value = false,
            )),
          ),
          const SizedBox(height: 12),
          _buildRow(
            label: "Name of the disease",
            widget: Obx(() => InkWell(
              onTap: () => _showDiseaseDialog(context, controller),
              child: Text(
                controller.diseaseName.value.isEmpty
                    ? "Enter name"
                    : controller.diseaseName.value,
                style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            )),
          ),
        ],
      ),
    );
  }
  Widget _buildRow({required String label, required Widget widget}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 2, child: Text(label)),
        const SizedBox(width: 10),
        Expanded(flex: 5, child: widget),
      ],
    );
  }


  Widget _yesNoToggle({
    required bool? value,
    required VoidCallback onYes,
    required VoidCallback onNo,
  }) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: onYes,
          style: ElevatedButton.styleFrom(
            backgroundColor: value == true ? Colors.greenAccent : Colors.grey[200],
            foregroundColor: Colors.black,
          ),
          child: const Text('YES'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: onNo,
          style: ElevatedButton.styleFrom(
            backgroundColor: value == false ? Colors.redAccent : Colors.grey[200],
            foregroundColor: Colors.black,
          ),
          child: const Text('NO'),
        ),
      ],
    );
  }

  void _showDiseaseDialog(BuildContext context, IrrigationController controller) {
    final tempController = TextEditingController(text: controller.diseaseName.value);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Enter Disease Name"),
        content: TextField(
          controller: tempController,
          decoration: const InputDecoration(hintText: "e.g., Leaf Blight"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              controller.diseaseName.value = tempController.text;
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
