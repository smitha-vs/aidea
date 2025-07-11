import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';


class CultivationController extends GetxController {
  final cropName = ''.obs;
  final numOfPatches = 0.obs;
  final selectedPatch = RxnInt();
  final cultivatedArea = ''.obs;
  final expectedDate = Rxn<DateTime>();
  final capturedImage = Rxn<File>();

  final numOfPatchesController = TextEditingController();
  final areaController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  void generateRandomPatch() {
    if (numOfPatches.value > 0) {
      selectedPatch.value = Random().nextInt(numOfPatches.value) + 1;
    }
  }

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
  final signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.green,
    exportBackgroundColor: Colors.white,
  );

  Future<void> captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera, imageQuality: 70);
    if (pickedFile != null) {
      capturedImage.value = File(pickedFile.path);
    }
  }

  @override
  void onClose() {
    numOfPatchesController.dispose();
    areaController.dispose();
    super.onClose();
  }
}
