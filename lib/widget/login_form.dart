import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/login.dart';
class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
   LoginForm({super.key, required this.formKey});
  final LoginViewController loginController = Get.put(LoginViewController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Email",
                style: TextStyle(
                  color: Color(0xFF0020A9),
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller:loginController.emailController,
                decoration: const InputDecoration(
                  hintText: "Enter Email",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              const Text(
                "Password",
                style: TextStyle(
                  color: Color(0xFF0020A9),
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(() => TextFormField(
                controller: loginController.passwordController,
                obscureText: !loginController.isPasswordVisible.value,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  prefixIcon: const Icon(Icons.key),
                  suffixIcon: IconButton(
                    icon: Icon(loginController.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: loginController.togglePasswordVisibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              Obx(() {
                return loginController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      loginController.login(
                        email: loginController.emailController.text.trim(),
                        password: loginController.passwordController.text.trim(),
                      );
                    } else {
                      Get.snackbar(
                        'Error',
                        'Please fill in all required fields correctly.',
                        backgroundColor: Colors.red.withOpacity(0.8),
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF010F58),
                          Color(0xFF0020A9),
                          Color(0xFF0020A9),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
