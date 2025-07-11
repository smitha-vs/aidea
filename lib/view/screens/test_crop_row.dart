// Updated CropTablePages with advanced features
import 'package:aidea/view/screens/dropdown_crops__example.dart';
import 'package:aidea/view/screens/test_crop_row.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_searchable_field/dropdown_searchable_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_search/flutter_dropdown_search.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/cce_controller.dart';
import '../../controller/cluster.dart';
import '../../controller/crop_area_show.dart';
import '../../controller/crop_data_save.dart';
import '../../controller/crop_dropdown_menu.dart';
import '../../controller/crop_row_test.dart';
import '../../controller/dropdown_crops.dart';
import '../../controller/plot_details.dart';
import '../../model/crop_list.dart';
import '../../resources/constants/colours.dart';
import '../../widget/crop_details_paddy_popup.dart';

class CropTablePages extends StatelessWidget {
  final String direction;
  CropTablePages({super.key, required this.direction});
  final CropControllers controller = Get.put(CropControllers());
  final ScrollController scrollController = ScrollController();
  final DirectionController directionController = Get.put(
    DirectionController(),
  );
  final MenuDropdownController menuController = Get.put(
    MenuDropdownController(),
  );
  final DropdownCropsController dropdownCropsController= Get.put(
    DropdownCropsController (),
  );
  final CropDataSave save = Get.put(CropDataSave());
  final cropName = 'Select Crop'.obs;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    final available =
                        menuController.getAvailableCropsForDropdown();
                    if (available.isEmpty) {
                      Get.snackbar(
                        "No More Crops",
                        "All available crops have been selected.",
                      );
                      return;
                    }
                    controller.addCropRow();
                    Future.delayed(const Duration(milliseconds: 100), () {
                      if (scrollController.hasClients) {
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      }
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Crop"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.black54,
          child: Row(
            children: const [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Crop Name",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Area (cents)",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              // Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
        Expanded(
          child: Obx(
                () => ListView.builder(
              controller: scrollController,
              itemCount: controller.cropRows.length,
              itemBuilder: (context, index) {
                final row = controller.cropRows[index];
                return _buildTableRow(context, index, row, screenWidth);
              },
            ),
          ),
        ),

        Obx(
          () =>
              controller.isSaving.value
                  ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Saving...",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }
  Widget _buildTableRow(
    BuildContext context,
    int index,
    CropRow row,
    double screenWidth,
  ) {
    final dropdownWidth = screenWidth * 0.55;
    final clusterController = Get.find<ClusterDetailController>(); // or pass it
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              final filteredCrops =
                  menuController.getAvailableCropsForDropdown();
              if (menuController.selectedCropTypeId.value == 0) {
                return GestureDetector(
                  onTap: () {
                    Get.snackbar(
                      "Crop Type Required",
                      "Please select a crop type before choosing a crop.",
                      backgroundColor: Colors.orange.shade100,
                      colorText: Colors.black,
                      snackPosition: SnackPosition.TOP,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade100,
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.warning_amber_rounded, color: Colors.orange),
                        SizedBox(width: 8),
                        Text(
                          "Select Crop (Disabled)",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              }
              final selectedIds = menuController.selectedCrops.map((e) => e.mappingId).toSet();

              return Center(
                child: Obx(() {
                  final availableCrops = dropdownCropsController.crops
                      .where((crop) =>
                  crop.seasonalClassificationName != SeasonalClassificationName.NO_CLASSIFICATION &&
                      !selectedIds.contains(crop.mappingId))
                      .toList();

                  return DropdownButtonHideUnderline(
                    child: DropdownButton2<AllCropsList>(
                      isExpanded: true,
                      hint: const Text('Select a crop'),
                      items: availableCrops.map((crop) {
                        final seasonalName = seasonalClassificationNameValues.reverse[crop.seasonalClassificationName];
                        final label = '${crop.cropNameEn} (${seasonalName?.capitalizeFirst})';
                        return DropdownMenuItem(
                          value: crop,
                          child: Text(label),
                        );
                      }).toList(),
                      value: dropdownCropsController.selectedCrop.value != null &&
                          dropdownCropsController.selectedCrop.value!.seasonalClassificationName !=
                              SeasonalClassificationName.NO_CLASSIFICATION &&
                          !selectedIds.contains(dropdownCropsController.selectedCrop.value!.mappingId)
                          ? dropdownCropsController.selectedCrop.value
                          : null,
                      onChanged: (value) async {
                        if (value != null &&
                            value.seasonalClassificationName != SeasonalClassificationName.NO_CLASSIFICATION &&
                            !selectedIds.contains(value.mappingId)) {

                          dropdownCropsController.setSelectedCrop(value);

                          /// 🔽 Compare area logic — make sure `row` is available in this context
                          if (row.pendingEnteredArea.value > 0) {
                            row.totalArea.value += row.pendingEnteredArea.value;
                            row.pendingEnteredArea.value = 0.0;
                            controller.calculateTotal();

                            if (!row.hasAutoSaved.value) {
                              row.hasAutoSaved.value = true;
                              Future.delayed(const Duration(milliseconds: 500), () {
                                controller.autoSaveCropDetails();
                              });
                            }
                          }
                        }
                      },
                      dropdownSearchData: DropdownSearchData(
                        searchController: dropdownCropsController.searchController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextField(
                            controller: dropdownCropsController.searchController,
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


              // Obx(() => DropdownButtonHideUnderline(
              //    child:DropdownExample()
              //   DropdownButton2<int>(
              //     isExpanded: true,
              //     hint: const Text('Search crop...'), // just show placeholder
              //     value: availableCrops.any((e) => e.mappingId == row.selectedMappingId.value)
              //         ? row.selectedMappingId.value
              //         : null,
              //     items: availableCrops.map((e) {
              //       final seasonalName = seasonalClassificationNameValues.reverse[e.seasonalClassificationName];
              //       final label = e.seasonalClassificationName == SeasonalClassificationName.NO_CLASSIFICATION
              //           ? e.cropNameEn
              //           : "${e.cropNameEn} ($seasonalName)";
              //       return DropdownMenuItem<int>(
              //         value: e.mappingId,
              //         child: Text(label),
              //       );
              //     }).toList(),
              //     onChanged: (selectedId) async {
              //       final selectedCrop = availableCrops.firstWhereOrNull((e) => e.mappingId == selectedId);
              //       if (selectedCrop == null) return;
              //
              //       // Update row state
              //       row.selectedMappingId.value = selectedCrop.mappingId;
              //       row.selectedCrop.value = selectedCrop;
              //
              //       // Set text in searchController just for internal tracking
              //       final seasonalName = seasonalClassificationNameValues.reverse[selectedCrop.seasonalClassificationName];
              //       row.searchController.text = selectedCrop.seasonalClassificationName == SeasonalClassificationName.NO_CLASSIFICATION
              //           ? selectedCrop.cropNameEn
              //           : "${selectedCrop.cropNameEn} ($seasonalName)";
              //
              //       // Auto save if needed
              //       if (row.totalArea.value > 0 && row.hasAutoSaved.isFalse) {
              //         row.hasAutoSaved.value = true;
              //         Future.delayed(const Duration(milliseconds: 500), () {
              //           controller.autoSaveCropDetails();
              //         });
              //       }
              //
              //       if (row.pendingEnteredArea.value > 0) {
              //         row.totalArea.value += row.pendingEnteredArea.value;
              //         row.pendingEnteredArea.value = 0.0;
              //         controller.calculateTotal();
              //         if (!row.hasAutoSaved.value) {
              //           row.hasAutoSaved.value = true;
              //           Future.delayed(const Duration(milliseconds: 500), () {
              //             controller.autoSaveCropDetails();
              //           });
              //         }
              //       }
              //
              //       menuController.selectedCrops.add(selectedCrop);
              //
              //       // Handle popups
              //       final popupCrops = {32, 33, 81, 25, 26};
              //       final prefs = await SharedPreferences.getInstance();
              //       final clusterID = prefs.getString('selectedClusterId') ?? '';
              //       final selected = directionController.selectedDirection.value;
              //       final idsToSend = clusterController.cropIds.toList();
              //
              //       if (popupCrops.contains(selectedCrop.mappingId)) {
              //         if (selected.isNotEmpty) {
              //           showCropSurveyPopup(
              //             context,
              //             selectedCrop.cropNameEn,
              //             clusterID,
              //                 (popupArea) {
              //               row.totalArea.value = popupArea;
              //               controller.calculateTotal();
              //             },
              //             direction,
              //           );
              //         } else {
              //           Get.snackbar("No Direction Selected", "Please select a direction first.");
              //         }
              //       } else if (idsToSend.contains(selectedCrop.mappingId)) {
              //         showOtherCropPopup(
              //           context,
              //           selectedCrop.cropNameEn,
              //           clusterID,
              //           direction,
              //               (popupArea) {
              //             row.totalArea.value = popupArea;
              //             controller.calculateTotal();
              //           },
              //         );
              //       }
              //     },
              //     dropdownSearchData: DropdownSearchData(
              //       searchController: row.searchController,
              //       searchInnerWidgetHeight: 50,
              //       searchInnerWidget: Padding(
              //         padding: const EdgeInsets.all(8),
              //         child: TextField(
              //           controller: row.searchController,
              //           decoration: InputDecoration(
              //             isDense: true,
              //             contentPadding: const EdgeInsets.all(12),
              //             hintText: 'Search crop...',
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //           ),
              //         ),
              //       ),
              //       searchMatchFn: (item, searchValue) {
              //         final itemText = item.child is Text ? (item.child as Text).data ?? '' : '';
              //         return itemText.toLowerCase().contains(searchValue.toLowerCase());
              //       },
              //     ),
              //     buttonStyleData: const ButtonStyleData(
              //       height: 50,
              //       width: double.infinity,
              //     ),
              //     dropdownStyleData: const DropdownStyleData(
              //       maxHeight: 300,
              //     ),
              //     menuItemStyleData: const MenuItemStyleData(
              //       height: 48,
              //     ),
              //   ),
              // )
              // );
            }),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: row.enterAreaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "Enter Area"),
                  onSubmitted: (val) {
                    final entered = double.tryParse(val) ?? 0.0;
                    if (row.selectedCrop.value == null) {
                      if (entered > 0) {
                        row.pendingEnteredArea.value = entered;
                      }
                      Get.snackbar(
                        "Crop Not Selected",
                        "Please select a crop before entering area.",
                        backgroundColor: Colors.red.shade100,
                        colorText: Colors.black,
                      );
                      return;
                    }
                    row.enterAreaController.clear();
                    if (entered <= 0) {
                      Get.snackbar(
                        "Invalid Area",
                        "Please enter a valid area value.",
                        backgroundColor: Colors.red.shade100,
                        colorText: Colors.black,
                      );
                      return;
                    }
                    row.hasAutoSaved.value = false;
                    row.totalArea.value += entered;
                    row.enterAreaController.clear();
                    controller.calculateTotal();
                    if (!row.hasAutoSaved.value) {
                      row.hasAutoSaved.value = true;
                      Future.delayed(
                        Duration(milliseconds: 500),
                            () => controller.autoSaveCropDetails(),
                      );
                    }
                  },
                ),
                Obx(
                  () =>
                      Text("Total: ${row.totalArea.value.toStringAsFixed(2)}"),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: IconButton(
            icon: Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () {
              menuController.reAddCropToList(row.selectedCrop.value);
              controller.removeCropRow(index);
            },
          ),
        ),
      ],
    );
  }
}
class MenuItems {
  final String label;
  MenuItems({required this.label});
}

class CropRow {
  Rx<AllCropsList?> selectedCrop = Rx<AllCropsList?>(null);
  RxInt selectedMappingId = 0.obs;
  TextEditingController enterAreaController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxDouble totalArea = 0.0.obs;
  RxBool isIrrigated = false.obs;
  RxBool isCcePlot = false.obs;
  RxBool hasAutoSaved = false.obs;
  RxDouble pendingEnteredArea = 0.0.obs;
  RxString selectedLabel = ''.obs;

}
