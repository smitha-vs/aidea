import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CropModel {
  final TextEditingController cropController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final RxString irrigatedValue = 'Yes'.obs;
  final RxString cceValue = 'Not Selected'.obs;
}
