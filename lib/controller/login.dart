import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/constants/path.dart';
import '../resources/utils/services/api_services.dart';
class LoginViewController extends GetxController {
  var isPasswordVisible = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  RxBool obscureText = true.obs;
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> sessionData = {
        'username': email,
        'password': password,
      };
      final response = await callEncryptedApi(
        apiUrl: loginUrl,
        sessionData: sessionData,
      );
      if (response.isNotEmpty) {
        Get.offAllNamed('/dashboardScreen');
      }
      return response;
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        backgroundColor: Colors.red.shade300,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return {};
    } finally {
      isLoading.value = false;
    }
  }
}