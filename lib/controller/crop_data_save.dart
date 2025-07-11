
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resources/constants/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
class CropDataSave extends GetxController{
  Future<void> saveCropDataField(Map<String, Object> cropData,String clusterId,String direction,) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final String url = saveCropData;
    try {
      final fullData = {
        ...cropData,
        "clusterLabel": direction,
        "clusterId": clusterId,
      };
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(fullData),
      );
      print(fullData);
      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
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
      print('Error while saving Crop  details: $e');
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