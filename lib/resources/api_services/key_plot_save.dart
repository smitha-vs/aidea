import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/keyplot_owner.dart';
class ApiService {
  static Future<bool> saveKeyPlotDetails(String name,String phone,String address,String clusterId) async {
    final prefs = await SharedPreferences.getInstance();
    const String url = 'https://2270-14-139-189-168.ngrok-free.app/earas-form1-entry/key-plot-details/save'; // Replace with actual endpoint
    final response = await http.post(
      Uri.parse(url),
      body: {
        "name":name,
        "mobileNumber":phone,
        "clusterId":clusterId,
        "address":address
      },
    );
    if (response.statusCode == 200) {
      print("Key Plottttttttttttttttt details");
      // You can parse response if needed
      return true;
    } else {
      print("errorrrrrrrrrrr");
      return false;
    }
  }
}
