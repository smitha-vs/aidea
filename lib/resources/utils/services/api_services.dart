import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../encrypt/file.dart';
var isLoading = true.obs;
Future<Map<String, dynamic>> callEncryptedApi({
  required String apiUrl,
  required Map<String, dynamic> sessionData,
}) async {
  isLoading.value = true;
  try {
    final String jsonString = jsonEncode(sessionData);
    final encrypted = EncryptionHelper.encryptDataFromJsonString(jsonString);
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'text/plain',
      },
      body: encrypted,
    );
    print(encrypted);
    if (response.statusCode == 200) {
      final decrypted = EncryptionHelper.decryptData(response.body);
      print(decrypted);
      final Map<String, dynamic> finalData = jsonDecode(decrypted);
      final token = finalData['payload']?['token'];
      final uid=finalData['payload']?['id'];
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        await prefs.setString('userid', uid);
      }
      return finalData;
    } else {
      throw Exception("API Error: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    Get.snackbar(
      'Login Failed',
      e.toString(),
      backgroundColor: Colors.red.shade300,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
    return {}; // Return empty map on failure
  } finally {
    isLoading.value = false;
  }
}
