import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/cce/cce_plot_list.dart';
import '../../resources/constants/path.dart';
class CcePlotController extends GetxController {
  var availablePlot = <Available>[].obs;
  var isLoading = true.obs;
  @override
  void onInit() {
    fetchAvailablePlots() ;
    super.onInit();
  }
  Future<void> fetchAvailablePlots() async {
    isLoading.value = true; // Start loading

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final String url = availablePlotList;

    try {
      final fullData = {
        "clusterId": '2611',
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(fullData),
      );

      if (response.statusCode == 200) {
        print(response.body);
        final availableList = availablePlotListFromJson(response.body);
        availablePlot.value = availableList.payload;
        print('Fetched ${availablePlot.length} plots');
      } else {
        print('Failed to load crops: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching crops: $e');
    } finally {
      isLoading.value = false; // ✅ Ensure this always runs
    }
  }

}