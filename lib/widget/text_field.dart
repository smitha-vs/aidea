import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/login.dart';

class MyTextField extends StatelessWidget {
  final String txt;
  final String hintText;
  final IconData? icon;
  final bool obscureText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final int? maxLine;
  final double? width;
  final bool enabled; // NEW

  const MyTextField({
    super.key,
    required this.txt,
    required this.hintText,
    this.icon,
    this.controller,
    this.validator,
    required this.obscureText,
    this.maxLine,
    this.width,
    this.enabled = true, // default true
  });

  @override
  Widget build(BuildContext context) {
    final LoginViewController loginController = Get.put(LoginViewController());
    return SizedBox(
      width: width,
      child: TextFormField(
        enabled: enabled, // <- Use this here
        maxLines: maxLine,
        controller: controller,
        obscureText: obscureText ? loginController.obscureText.value : false,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          //labelText: txt,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: const Color(0xFFF2F2F2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: obscureText
              ? IconButton(
            icon: Icon(
              loginController.obscureText.value
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.black,
            ),
            onPressed: loginController.togglePasswordVisibility,
          )
              : null,
        ),
      ),
    );
  }
}
