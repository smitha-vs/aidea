import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/crop_dropdown_menu.dart';
import '../controller/plot_details.dart';
import '../model/dropdown_crop_item.dart';
import '../resources/constants/colours.dart';
import '../widget/pop_up.dart';

class CropRow {
  final cropName = 'Select Crop'.obs;
  final totalArea = ''.obs;
  final areaInput = ''.obs;
  final areaController = TextEditingController();
  final inputController = TextEditingController();
  final isIrrigated = false.obs;
  final isCCECrop = false.obs;
  final irrigationSource = ''.obs;
  final sourceArea = 0.obs;
  final MenuDropdownController menuController = Get.put(MenuDropdownController());

  DataRow buildRow(CropController controller, int index) {
    return DataRow(cells: [
      DataCell(
        Obx(() {
          final screenWidth = MediaQuery.of(Get.context!).size.width;
          final dropdownWidth = screenWidth * 0.75; // Adjust the percentage as needed
          return
            SizedBox(
              width: dropdownWidth,
              // child: DropdownMenu<MenuItems>(
              //   width: dropdownWidth,
              // controller: menuController.searchController,
              // hintText: "Crop List",
              // requestFocusOnTap: true,
              // enableFilter: true,
              // label: const Text('Select Crop'),
              // menuStyle: MenuStyle(
              //   backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue.shade50),
              // ),
              // initialSelection: menuController.selectedMenu.value,
              // onSelected: (MenuItems? menu) {
              //   menuController.selectMenu(menu);
              //   cropName.value = menu?.label ?? 'Select Crop';
              //   Get.dialog(
              //     AlertDialog(
              //       title: Text('Crop Details: ${cropName.value}'),
              //       content: SingleChildScrollView(
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             Obx(() => TextField(
              //               controller: TextEditingController(text: totalArea.value)
              //                 ..selection = TextSelection.collapsed(offset: totalArea.value.length),
              //               readOnly: true,
              //               decoration: const InputDecoration(labelText: 'Total Area (in cents)'),
              //             )),
              //             const SizedBox(height: 8),
              //             TextField(
              //               controller: inputController,
              //               keyboardType: const TextInputType.numberWithOptions(decimal: true),
              //               decoration: const InputDecoration(
              //                 labelText: 'Enter Area (in cents)',
              //                 border: OutlineInputBorder(),
              //               ),
              //               onSubmitted: (_) => addToTotal(),
              //             ),
              //             const SizedBox(height: 12),
              //             Obx(() => CheckboxListTile(
              //               title: const Text('Irrigated'),
              //               value: isIrrigated.value,
              //               onChanged: (value) => isIrrigated.value = value!,
              //             )),
              //             Obx(() => CheckboxListTile(
              //               title: const Text('CCE Crop'),
              //               value: isCCECrop.value,
              //               onChanged: (value) {
              //                 isCCECrop.value = value!;
              //                 if (value) {
              //                   Get.defaultDialog(
              //                     title: 'CCE Crop Details',
              //                     content: const Column(
              //                       children: [
              //                         PopUp(),
              //                       ],
              //                     ),
              //                     textConfirm: 'Ok',
              //                     confirmTextColor: Colors.white,
              //                     onConfirm: () => Get.back(),
              //                   );
              //                 }
              //               },
              //             )),
              //             const SizedBox(height: 8),
              //             ElevatedButton(
              //               onPressed: () {
              //                 controller.removeCrop(index);
              //                 Get.back();
              //               },
              //               style: ElevatedButton.styleFrom(backgroundColor: AppColour.desBlueColor),
              //               child: const Text('Remove Crop', style: TextStyle(color: Colors.white)),
              //             ),
              //           ],
              //         ),
              //       ),
              //       actions: [
              //         TextButton(
              //           onPressed: () => Get.back(),
              //           child: const Text('Close'),
              //         ),
              //       ],
              //     ),
              //   );
              // },
              // dropdownMenuEntries: menuController.menuItems
              //     .map<DropdownMenuEntry<MenuItems>>((MenuItems item) {
              //   return DropdownMenuEntry<MenuItems>(
              //     value: item,
              //     label: item.label,
              //   );
              // }).toList(),
              //           ),
            );
        }),
      ),

    ]);
  }
  void addToTotal() {
    final input = double.tryParse(inputController.text) ?? 0.0;
    final currentTotal = double.tryParse(totalArea.value) ?? 0.0;
    final newTotal = currentTotal + input;
    totalArea.value = newTotal.toStringAsFixed(2);
    inputController.clear();
  }
}
