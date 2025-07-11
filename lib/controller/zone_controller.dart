import 'dart:convert';
import 'package:aidea/resources/constants/path.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/zone_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ZoneController extends GetxController {
  var isLoading = true.obs;
  var data = Rxn<ZoneDetails>(); // Holds the full response model
  final String apiUrl = zoneDetails;

  @override
  void onInit() {
    fetchZoneDetails();
    super.onInit();
  }
  Future<void> fetchZoneDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        data.value = ZoneDetails.fromJson(jsonResponse);
      } else {
        Get.snackbar("Error", "Failed to load zone details: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
