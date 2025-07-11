import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/crop_list.dart';
import '../resources/constants/path.dart';
class DropdownCropsController extends GetxController {
  RxList<AllCropsList> crops = <AllCropsList>[].obs;
  Rxn<AllCropsList> selectedCrop = Rxn<AllCropsList>();
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCropsFromApi();
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
      } else {
        print('Failed to load crops: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching crops: $e');
    }
  }

  void setSelectedCrop(AllCropsList? value) {
    selectedCrop.value = value;
  }
}
