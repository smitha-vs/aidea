// import 'package:aidea/widget/pop_up.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/crop_dropdown_menu.dart';
// import '../controller/plot_details.dart';
// import '../model/crop_list.dart';
// class CropAreaTable extends StatelessWidget {
//   final String direction;
//   CropAreaTable({super.key, required this.direction});
//   final TextEditingController cropController = TextEditingController();
//   final MenuDropdownController menuController = Get.put(MenuDropdownController());
//   final RxString irrigatedValue = 'Yes'.obs;
//   final RxString cceValue = 'Not Selected'.obs;
//   final selectedCrop = 'Select Crop'.obs;
//   final area = 0.obs;
//   final isIrrigated = false.obs;
//   final irrigationSource = ''.obs;
//   final sourceArea = 0.obs;
//   final isCCECrop = false.obs;
//   final totalArea = ''.obs;
//   final areaController = TextEditingController();
//   final inputController = TextEditingController();
//   final totalAreaController = TextEditingController();
//   final cropName = 'Select Crop'.obs;
//   @override
//   Widget build(BuildContext context) {
//     String getDirectionLabel(String code) {
//       switch (code) {
//         case 'K':
//           return 'Key Plot';
//         case 'N':
//           return 'North';
//         case 'S':
//           return 'South';
//         case 'E':
//           return 'East';
//         case 'W':
//           return 'West';
//         default:
//           return '';
//       }
//     }
//     final CropController controller = Get.put(CropController());
//     totalAreaController.text = totalArea.value;
//     totalAreaController.selection = TextSelection.collapsed(
//       offset: totalAreaController.text.length,
//     );
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Obx(
//             () => DataTable(
//               dataRowHeight: 100,
//               headingRowColor: WidgetStateProperty.all(Colors.blue.shade200),
//               headingTextStyle: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//               border: TableBorder.all(color: Colors.black26),
//               columns: const [
//                 DataColumn(label: Text('Crop')),
//                 DataColumn(label: Text('Area')),
//                 DataColumn(label: Text('Irrigated')),
//                 DataColumn(label: Text('CCE')),
//                 DataColumn(label: Text('Action')),
//               ],
//               rows: List.generate(controller.cropList.length, (index) {
//                 final crop = controller.cropList[index];
//                 return DataRow(
//                   cells: [
//                     DataCell(
//                       Obx(() {
//                         final screenWidth = MediaQuery.of(Get.context!).size.width;
//                         final dropdownWidth = screenWidth * 0.75; // Adjust the percentage as needed
//                         return
//                           SizedBox(
//                             width: dropdownWidth,
//                             child: DropdownMenu<Form1Crops>(
//                               width: dropdownWidth,
//                               controller: menuController.searchController,
//                               hintText: "Crop List",
//                               requestFocusOnTap: true,
//                               enableFilter: true,
//                               label: const Text('Select Crop'),
//                               menuStyle: MenuStyle(
//                                 backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue.shade50),
//                               ),
//                               initialSelection: menuController.selectedMenu.value,
//                               onSelected: (Form1Crops? menu) {
//                                 menuController.selectMenu(menu);
//                                 cropName.value = menu?.cropNameEn ?? 'Select Crop';
//                               },
//                               dropdownMenuEntries: menuController.getAvailableCropsForDropdown()
//                                   .map<DropdownMenuEntry<Form1Crops>>((Form1Crops item) {
//                                 return DropdownMenuEntry<Form1Crops>(
//                                   value: item,
//                                   label: item.cropNameEn,
//                                 );
//                               }).toList(),
//
//                             )
//
//                           );
//                       }),
//                     ),
//                     DataCell(
//                       SizedBox(
//                         width: 200,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               flex: 1,
//                               child: Obx(() {
//                                 totalAreaController.text = totalArea.value;
//                                 totalAreaController
//                                     .selection = TextSelection.collapsed(
//                                   offset: totalAreaController.text.length,
//                                 );
//                                 return TextField(
//                                   controller: totalAreaController,
//                                   readOnly: true,
//                                   decoration: const InputDecoration(
//                                     labelText: 'Total Area',
//                                     border: OutlineInputBorder(),
//                                     contentPadding: EdgeInsets.symmetric(
//                                       horizontal: 8,
//                                       vertical: 10,
//                                     ),
//                                   ),
//                                 );
//                               }),
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               flex: 1,
//                               child: TextField(
//                                 controller: inputController,
//                                 keyboardType:
//                                     const TextInputType.numberWithOptions(
//                                       decimal: true,
//                                     ),
//                                 decoration: const InputDecoration(
//                                   labelText: 'Enter Area',
//                                   border: OutlineInputBorder(),
//                                   contentPadding: EdgeInsets.symmetric(
//                                     horizontal: 8,
//                                     vertical: 10,
//                                   ),
//                                 ),
//                                 onSubmitted: (_) => addToTotal(),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     DataCell(
//                       Obx(
//                         () => Checkbox(
//                           value: isIrrigated.value,
//                           onChanged: (value) {
//                             isIrrigated.value = value!;
//                             if (value) {
//                               final TextEditingController sourceController =
//                                   TextEditingController();
//                               final TextEditingController areaController =
//                                   TextEditingController();
//                               Get.defaultDialog(
//                                 title: 'Irrigation Details',
//                                 content: Column(
//                                   children: [
//                                     const Text(
//                                       'Enter source of irrigation and area (in cents):',
//                                     ),
//                                     const SizedBox(height: 10),
//                                     TextField(
//                                       controller: sourceController,
//                                       decoration: const InputDecoration(
//                                         labelText: 'Source of Irrigation',
//                                         border: OutlineInputBorder(),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 10),
//                                     TextField(
//                                       controller: areaController,
//                                       keyboardType: TextInputType.number,
//                                       decoration: const InputDecoration(
//                                         labelText: 'Area Covered',
//                                         border: OutlineInputBorder(),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 textConfirm: 'Save',
//                                 confirmTextColor: Colors.white,
//                                 onConfirm: () {
//                                   irrigationSource.value =
//                                       sourceController.text;
//                                   sourceArea.value =
//                                       int.tryParse(areaController.text) ?? 0;
//                                   Get.back(); // close dialog
//                                 },
//                                 textCancel: 'Cancel',
//                               );
//                             }
//                           },
//                         ),
//                       ),
//                     ),
//                     DataCell(
//                       Obx(
//                         () => Checkbox(
//                           value: isCCECrop.value,
//                           onChanged: (value) {
//                             isCCECrop.value = value!;
//                             if (value) {
//                               Get.defaultDialog(
//                                 title: 'CCE Plot Details',
//                                 content: const Column(
//                                   children: [
//                                     Text(
//                                       'This crop is marked for CCE.\nPlease confirm or enter additional details.',
//                                     ),
//                                     SizedBox(height: 10),
//                                     PopUp(),
//                                   ],
//                                 ),
//                                 textConfirm: 'Ok',
//                                 confirmTextColor: Colors.white,
//                                 onConfirm: () {
//                                   Get.back(); // close the dialog
//                                 },
//                               );
//                             }
//                           },
//                         ),
//                       ),
//                     ),
//                     DataCell(
//                       IconButton(
//                         icon: const Icon(Icons.delete, color: Colors.red),
//                         onPressed: () => controller.removeCrop(index),
//                       ),
//                     ),
//                   ],
//                 );
//               }),
//             ),
//           ),
//           // const SizedBox(height: 20),
//           // Center(
//           //   child: ElevatedButton.icon(
//           //     onPressed: controller.addCrop,
//           //     icon: const Icon(Icons.add, color: Colors.white),
//           //     label: const Text('Add Crop', style: TextStyle(color: Colors.white)),
//           //     style: ElevatedButton.styleFrom(
//           //       backgroundColor: AppColour.desBlueColor,
//           //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//           //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           //     ),
//           //   ),
//           // ),
//         ),
//       ],
//     );
//   }
//
//   void addToTotal() {
//     final input = double.tryParse(inputController.text) ?? 0.0;
//     final currentTotal = double.tryParse(totalArea.value) ?? 0.0;
//     final newTotal = currentTotal + input;
//     totalArea.value = newTotal.toStringAsFixed(2);
//     inputController.clear();
//   }
// }
