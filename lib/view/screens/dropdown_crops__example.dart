import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/dropdown_crops.dart';
import '../../model/crop_list.dart';
class DropdownExample extends StatelessWidget {
  const DropdownExample({super.key});
  @override
  Widget build(BuildContext context) {
    final DropdownCropsController controller = Get.put(DropdownCropsController());
    return Center(
      child: Obx(() {
        final availableCrops = controller.crops
            .where((crop) => crop.seasonalClassificationName != SeasonalClassificationName.NO_CLASSIFICATION)
            .toList();
        return DropdownButtonHideUnderline(
          child: DropdownButton2<AllCropsList>(
            isExpanded: true,
            hint: const Text('Select a crop'),
            items: availableCrops.map((crop) {
              final seasonalName = seasonalClassificationNameValues
                  .reverse[crop.seasonalClassificationName];
              final label = '${crop.cropNameEn} (${seasonalName?.capitalizeFirst})';

              return DropdownMenuItem(
                value: crop,
                child: Text(label),
              );
            }).toList(),

            // ✅ Only allow valid crops as selected
            value: controller.selectedCrop.value != null &&
                controller.selectedCrop.value!.seasonalClassificationName !=
                    SeasonalClassificationName.NO_CLASSIFICATION
                ? controller.selectedCrop.value
                : null,

            onChanged: (value) {
              if (value != null &&
                  value.seasonalClassificationName !=
                      SeasonalClassificationName.NO_CLASSIFICATION) {
                controller.setSelectedCrop(value);
              }
            },

            dropdownSearchData: DropdownSearchData(
              searchController: controller.searchController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: controller.searchController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(12),
                    hintText: 'Search crops...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return item.value?.cropNameEn
                    .toLowerCase()
                    .contains(searchValue.toLowerCase()) ??
                    false;
              },
            ),

            buttonStyleData: const ButtonStyleData(
              height: 50,
              width: 250,
            ),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 300,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        );
      }),
    );
  }
}
