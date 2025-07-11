import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurveyController extends GetxController {
  var selectedSurvey = ''.obs;
  var areaController = TextEditingController();
  var surveyList = <String>['101', '102', '103', '104'].obs; // Sample survey numbers
  var addedList = <Map<String, String>>[].obs;

  // void addSurveyData() {
  //   if (selectedSurvey.value.isNotEmpty && areaController.text.isNotEmpty) {
  //     addedList.add({
  //       'survey': selectedSurvey.value,
  //       'area': areaController.text,
  //     });
  //     areaController.clear();
  //     selectedSurvey.value = '';
  //     Get.back(); // Close the dialog
  //   }
  // }
  var totalArea = 0.0.obs;

  void addSurveyData() {
    if (selectedSurvey.value.isNotEmpty && areaController.text.isNotEmpty) {
      final area = double.tryParse(areaController.text) ?? 0.0;
      addedList.add({
        'survey': selectedSurvey.value,
        'area': areaController.text,
      });

      totalArea.value += area; // ✅ Update total area
      areaController.clear(); // ✅ Clear enter area field
      selectedSurvey.value = ''; // Optional: Reset dropdown
      Get.back();
    }
  }

}
