import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/seasonal_crop.dart'; // Adjust this import as needed

class CropTypeDropdown extends StatelessWidget {
  const CropTypeDropdown({super.key});
  @override
  Widget build(BuildContext context) {
    final CropTypeController controller = Get.put(CropTypeController());
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            'Select Crop Type:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(20),
              color: Colors.orange.withOpacity(0.1),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.selectedCropType.value,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.orange),
                dropdownColor: Colors.white,
                items: [
                  DropdownMenuItem(value: 'Annual', child: Text('Annual')),
                  DropdownMenuItem(value: 'Pereneal', child: Text('Pereneal')),
                  DropdownMenuItem(value: 'Seasonal', child: Text('Seasonal')),
                ],
                onChanged: controller.setCropType,
              ),
            ),
          ),
        ],
      );
    });
  }
}
