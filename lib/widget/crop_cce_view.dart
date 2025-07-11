import 'package:aidea/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cce_controller.dart';
import '../controller/drop_down.dart';
import '../resources/constants/screen_responsive.dart';
import 'cce_tree_detail_view.dart';
import 'my_dropdown.dart';
class CropCCEView extends StatelessWidget {
  const CropCCEView({super.key});
  @override
  Widget build(BuildContext context) {
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    final DropdownController cropController = Get.put(DropdownController());
    final controller = Get.put(CategoryTabController());
    return 
      SingleChildScrollView(
        child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Crop Type', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5.0),
            MyDropdown(
        label: '',
        items: ['Paddy', 'Wheat', 'Maize'],
        selectedValue: cropController.selectedCrop,
        width: MediaQuery.of(context).size.width * 0.8,
            ),
            const SizedBox(height: 20.0),
            const Text('Number of Patches', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5.0),
            MyTextField(
              txt: '',
              hintText: '',
              obscureText: false,
              width: responsive.screenWidth * 0.8,
              controller: TextEditingController(text: '12'),
              enabled: false,
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Random Number', style: TextStyle(fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  onPressed: () =>  controller.fetchRandomNumber(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh'),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            TreeDetailView()
          ],
        ),
            ),
      );
  }
}
