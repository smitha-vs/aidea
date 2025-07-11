import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../resources/constants/path.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
class KeyplotSave extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  @override
  void onInit() {
    super.onInit();
    _fetchLocation(); // Automatically fetch location when controller is initialized
  }
  Future<void> _fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      latitude.value = position.latitude.toString();
      longitude.value = position.longitude.toString();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('latitude', latitude.value);
      await prefs.setString('longitude', longitude.value);
      debugPrint('Location Captured: ${latitude.value}, ${longitude.value}');
    } catch (e) {
      debugPrint('Error fetching location: $e');
    }
  }
  Future<void> saveKeyPlotDetails(
      String name, String phone, String address, String clusterId,String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final String url = keyPlotSave;
    try {
      Map<String, dynamic> sessionData = {
        "name": name,
        "mobileNumber": phone,
        "clusterId": clusterId,
        "address": address,
        "userId":userId,
        "geocoordinate": "${latitude.value},${longitude.value}",
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