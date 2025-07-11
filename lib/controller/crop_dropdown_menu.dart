import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/crop_list.dart';
import '../resources/constants/path.dart';

class MenuDropdownController extends GetxController {
  final Rx<AllCropsList?> selectedMenu = Rx<AllCropsList?>(null);
  final TextEditingController searchController = TextEditingController();
  final RxList<AllCropsList> crops = <AllCropsList>[].obs;
  final RxList<AllCropsList> selectedCrops = <AllCropsList>[].obs;
  final Rx<CropType?> selectedCropType = Rx<CropType?>(null);
  final RxInt selectedCropTypeId = 0.obs;
  final Rx<String> selectedSeason = ''.obs;
  RxList<CropTypeItem> cropTypes = <CropTypeItem>[].obs;
  void extractCropTypesFromCrops() {
    final seen = <int>{};
    final uniqueTypes = <CropTypeItem>[];
    for (var crop in crops) {
      final typeId = crop.masterCropTypeResponse.cropTypeId;
      if (!seen.contains(typeId)) {
        seen.add(typeId);
        uniqueTypes.add(CropTypeItem(
          typeId,
          crop.masterCropTypeResponse.cropType,
        ));
      }
    }
    cropTypes.assignAll(uniqueTypes);
  }
  @override
  void onInit() {
    super.onInit();
    fetchCropsFromApi();
    selectedSeason.value = _getDefaultSeason();
    final perennial = cropTypes.firstWhereOrNull(
          (item) => cropTypeValues.reverse[item.cropTypeId] == "2",
    );
    if (perennial != null) {
      selectedCropTypeId.value = perennial.cropTypeId;
    }
  }
  String _getDefaultSeason() {
    final month = DateTime.now().month;
    if (month >= 7 && month <= 10) {
      return 'Autumn';
    } else if (month >= 11 && month <= 12) {
      return 'Winter';
    } else {
      return 'Summer';
    }
  }
  void selectMenu(AllCropsList? item) {
    if (item != null && !selectedCrops.contains(item)) {
      selectedCrops.add(item);
    }
    selectedMenu.value = item;
    searchController.text = item?.cropNameEn ?? '';
  }

  void deselectMenu(AllCropsList? item) {
    selectedCrops.remove(item);
  }
  void reAddCropToList(AllCropsList? crop) {
    if (crop != null && !crops.contains(crop)) {
      crops.add(crop);
    }
    selectedCrops.remove(crop);
  }

  Future<void> fetchCropsFromApi() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final String url = cropListUrl;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<AllCropsList> data = allCropsListFromJson(response.body);
        crops.assignAll(data);
        extractCropTypesFromCrops(); // 👈 Add this line
      } else {
        print('Failed to load crops: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching crops: $e');
    }
  }
  List<AllCropsList> getFilteredCropsByType() {
    if (selectedCropType.value == null) return [];
    return crops
        .where((crop) => crop.masterCropTypeResponse.cropType == selectedCropType.value)
        .toList();
  }
  List<AllCropsList> getAvailableCropsForDropdown() {
    if (selectedCropTypeId.value == 0) return [];
    return crops
        .where((crop) =>
    crop.masterCropTypeResponse.cropTypeId == selectedCropTypeId.value &&
        !selectedCrops.contains(crop))
        .toList();
  }
}
