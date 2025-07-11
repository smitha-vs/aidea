import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/source_list.dart';
import '../resources/constants/path.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
class IrrigationEntry {
  IriSources? selectedSource;
  TextEditingController areaController = TextEditingController();
}
class IrrigationDetailsSave extends GetxController {
  RxList<IriSources> iriSources = <IriSources>[].obs;
  Rxn<IriSources> selectedCrop = Rxn<IriSources>(); // Legacy field
  RxList<IrrigationEntry> irrigationEntries = <IrrigationEntry>[].obs;
  TextEditingController grossArea = TextEditingController();
  TextEditingController netArea = TextEditingController();
  RxString grossAreaFromAPI = ''.obs;
  final String url = fetchSources;
  @override
  void onInit() {
    fetchSourcesFromApi();
    irrigationEntries.add(IrrigationEntry()); // Initialize with one row
    super.onInit();
  }
  Future<void> fetchSourcesFromApi() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = Sources.fromJson(jsonDecode(response.body));
        iriSources.assignAll(data.payload);
      } else {
        print('Failed to load Sources');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  List<IriSources> getAvailableSourceForDropdown({bool avoidDuplicates = false}) {
    if (!avoidDuplicates) return iriSources;
    final selectedSet = irrigationEntries
        .map((entry) => entry.selectedSource?.irrigationType)
        .whereType<String>()
        .toSet();
    return iriSources
        .where((source) => !selectedSet.contains(source.irrigationType))
        .toList();
  }
  void addIrrigationEntry() {
    irrigationEntries.add(IrrigationEntry());
  }
  Future<void> saveIrrigationDetails(
      String grossArea,
      String netArea,
      String clusterId,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final String urls = saveIrrigation;

    try {
      List<Map<String, dynamic>> sourceDetails = [];

      for (var entry in irrigationEntries) {
        if (entry.selectedSource != null &&
            entry.areaController.text.trim().isNotEmpty) {
          sourceDetails.add({
            "sourceId": entry.selectedSource!.sourceId,
            "area": double.tryParse(entry.areaController.text.trim()) ?? 0,
          });
        }
      }
      Map<String, dynamic> sessionData = {
        "grossArea": grossArea,
        "netArea": netArea,
        "clusterId": clusterId,
        "sourceDetails": sourceDetails,
      };
      print("Sending data: $sessionData");

      final response = await http.post(
        Uri.parse(urls),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(sessionData),
      );
      if (response.statusCode == 201) {
        print(response.body);
        Get.snackbar(
          'Success',
          'Irrigation details saved!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      } else {
        throw Exception('Failed to save data');
      }
    } catch (e) {
      print('Error while saving Irrigation details: $e');
      Get.snackbar(
        'Error',
        '$e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }

}
