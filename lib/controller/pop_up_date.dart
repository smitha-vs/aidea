import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopUpDate extends GetxController {
  final areaController = TextEditingController();
  final farmerNameController = TextEditingController();
  final addressController = TextEditingController();
  final mobileController = TextEditingController();
  final remarksController = TextEditingController();
  final expectedDate = Rxn<DateTime>();
  void pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: expectedDate.value ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 10),
    );
    if (picked != null) {
      expectedDate.value = picked;
    }
  }
  void clearFields() {
    areaController.clear();
    farmerNameController.clear();
    addressController.clear();
    mobileController.clear();
    remarksController.clear();
    expectedDate.value = null;
  }
  @override
  void onClose() {
    areaController.dispose();
    farmerNameController.dispose();
    addressController.dispose();
    mobileController.dispose();
    remarksController.dispose();
    super.onClose();
  }
}