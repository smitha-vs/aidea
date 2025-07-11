import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/crop_dropdown_menu.dart';
import '../../controller/crop_row_test.dart';
import '../../model/crop_list.dart';
class CropDropdownForm extends StatelessWidget {
  CropDropdownForm({super.key});
  final MenuDropdownController menuDropdownController = Get.put(
    MenuDropdownController(),
  );
  final CropControllers cropController = Get.find<CropControllers>();
  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration(String hint) {
      return InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        hintStyle: const TextStyle(color: Colors.grey),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(() {
          return DropdownButtonFormField<String>(
            value: menuDropdownController.selectedSeason.value,
            decoration: inputDecoration("Select Season"),
            items: ['Autumn', 'Winter', 'Summer']
                .map((season) => DropdownMenuItem(
              value: season,
              child: Text(season),
            ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                menuDropdownController.selectedSeason.value = value;
              }
            },
          );
        }),
        const SizedBox(height: 16),
        Obx(() {
          return DropdownButtonFormField<int>(
            decoration: inputDecoration("Select Crop Type"),
            value:
                menuDropdownController.selectedCropTypeId.value == 0
                    ? null
                    : menuDropdownController.selectedCropTypeId.value,
            items:
                menuDropdownController.cropTypes.map((item) {
                  return DropdownMenuItem<int>(
                    value: item?.cropTypeId,
                    child: Text(
                      cropTypeValues.reverse[item.cropType]!.capitalizeFirst!,
                    ),
                  );
                }).toList(),
            onChanged: (value) {
              if (value != null) {
                menuDropdownController.selectedCropTypeId.value = value;
              }
            },
          );
        }),
        SizedBox(height: 20,),
        Text("Crop Area",style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        SizedBox(height: 10,),
        TextField(
          controller: TextEditingController(
            text: cropController.totalEnteredAreaRx.value.toStringAsFixed(2),
          ),
          enabled: false,
          decoration: inputDecoration("CCE Crop"),
          style: const TextStyle(color: Colors.black), // Text color
        ),
      ],
    );
  }
}
