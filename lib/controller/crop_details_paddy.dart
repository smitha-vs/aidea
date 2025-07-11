import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/constants/path.dart';
import 'cluster.dart';
class CropSurveyPopupController extends GetxController {
  final String direction;
  CropSurveyPopupController(this.direction);
  var rows = <SurveyRow>[].obs;
  var totalArea = 0.0.obs;
  var surveyList = <String>[].obs;
  var selectedSurveyNo = RxnString();
  RxBool isIrrigated = true.obs; // Default to Irrigated
  @override
  void onInit() {
    super.onInit();
    loadSurveyNumbers();
  }

  void loadSurveyNumbers() {
    final plots = Get.find<ClusterDetailController>().data.value?.labels[direction] ?? [];
    surveyList.value = plots.map((e) => e.svNo).toList(); // convert to list of strings
  }

  void addRow() {
    rows.add(SurveyRow());
  }

  void removeRow(int index) {
    if (rows.length > 1) {
      rows.removeAt(index);
      update();
    }
  }

  void recalculateTotalArea() {
    double total = 0.0;
    for (var row in rows) {
      final text = row.areaController.text;
      final value = double.tryParse(text) ?? 0.0;
      total += value;
    }
    totalArea.value = total;
  }
  Future<void> savePaddyDetails(
      String name, String phone, String address, String clusterId,String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final String url = paddySave;
    try {
      Map<String, dynamic> sessionData = {
        "name": name,
        "mobileNumber": phone,
        "clusterId": clusterId,
        "address": address,
        "userId":userId,
      };
      print("Sending data: $sessionData");
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(sessionData),
      );
      if (response.statusCode == 201 || response.statusCode==200) {
        final jsonData = jsonDecode(response.body);
        print(jsonData);
        Get.snackbar(
          'Success',
          'Key Plot details saved!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
      } else {
        throw Exception('Failed to save data');
      }
    } catch (e) {
      print('Error while saving Key Plot details: $e');
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
class SurveyRow {
  String? selectedSurveyNo;
  TextEditingController areaController = TextEditingController();
}
