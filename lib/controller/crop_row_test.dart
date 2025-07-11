import 'dart:convert';

import 'package:aidea/controller/plot_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../resources/constants/path.dart';
import '../view/screens/test_crop_row.dart';
import 'cce_controller.dart';
import 'crop_dropdown_menu.dart';

class CropControllers extends GetxController {
  var cropRows = <CropRow>[].obs;
  var menuItems = <MenuItems>[].obs;
  var isSaving = false.obs; // Show indicator during auto-save

  @override
  void onInit() {
    super.onInit();
    fetchMenuItems();
    addCropRow();
  }

  void fetchMenuItems() {
    menuItems.value = [
      MenuItems(label: 'Paddy'),
      MenuItems(label: 'Wheat'),
      MenuItems(label: 'Sugarcane'),
    ];
  }

  void addCropRow() {
    cropRows.add(CropRow());
  }

  void removeCropRow(int index) {
    cropRows.removeAt(index);
  }

  bool validateAll() {
    for (int i = 0; i < cropRows.length; i++) {
      var row = cropRows[i];
      if (row.selectedCrop.value == null) {
        Get.snackbar("Validation Error", "Crop is required at row ${i + 1}",
            backgroundColor: Colors.red.shade100);
        return false;
      }
    }
    return true;
  }
  void saveData() {
    if (validateAll()) {
      Get.defaultDialog(
        title: "Success",
        middleText: "Crop details saved successfully!",
        textConfirm: "OK",
        onConfirm: () => Get.back(),
      );
    }
  }
  void clearCropRows() {
    cropRows.clear();
    addCropRow();
  }

  double get totalEnteredArea {
    return cropRows.fold(0.0, (sum, row) => sum + row.totalArea.value);
  }
  void autoSaveCropDetails() async {
    final selected = Get.find<DirectionController>().selectedDirection.value;
    final selectedSeason = Get.find<MenuDropdownController>().selectedSeason.value;
    final irrigatedStatus = Get.find<ToggleTabController>().isIrrigated;

    List<Map<String, dynamic>> cropList = [];
    for (var row in cropRows) {
      final mappingId = row.selectedMappingId.value;
      final area = row.totalArea.value.toString();
      if (mappingId != 0 && area != '0.0') {
        cropList.add({
          "cropId": mappingId,
          "cropArea": area,
        });
      }
    }

    if (cropList.isNotEmpty && selected.isNotEmpty) {
      isSaving.value = true;
      await Future.delayed(Duration(milliseconds: 300)); // optional debounce delay
      await saveCropDetails(cropList, selected, irrigatedStatus.toString(), selectedSeason);
      isSaving.value = false;
    }
  }
  RxDouble totalEnteredAreaRx = 0.0.obs;
  void calculateTotal() {
    totalEnteredAreaRx.value = cropRows.fold(0.0, (sum, row) => sum + row.totalArea.value);
  }
  Future<void> saveCropDetails(List<Map<String, dynamic>> crops,String clusterLabel,String isIrrigated,String seasonType ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final userId= prefs.getString('userid') ?? '';
    final clusterID = prefs.getString('selectedClusterId') ?? '';
    final cropType=Get.find<MenuDropdownController>().selectedCropTypeId.value;
    final String url = saveCropData;
    try {
      Map<String, dynamic> sessionData = {
        "clusterId": clusterID,
        "clusterLabel": clusterLabel,
        "isIrrigated": isIrrigated,
        "userId":userId,
        "seasonType":seasonType,
        "crops":crops,
        "cropType":cropType,
      };
      print(sessionData);
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(sessionData),
      );
      print(sessionData);
      if (response.statusCode == 201) {
        print(response);
        final jsonData = jsonDecode(response.body);
        print(jsonData);
        Get.snackbar(
          'Success',
          'Crop details saved!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
      } else {
        throw Exception('Failed to save data');
      }
    } catch (e) {
      Get.snackbar(
        'Error', '$e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
  }
}
