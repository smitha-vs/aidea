// controllers/area_controller.dart
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/crop_area_show.dart';
class AreaController extends GetxController {
  var isLoading = true.obs;
  var areaData = Rxn<AreaModel>();
  final cropAreaController = TextEditingController();
  final enumeratedAreaController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    fetchAreaData();
  }
  void fetchAreaData() {
    Future.delayed(const Duration(seconds: 1), () {
      final area = AreaModel(cropArea: 100.5, enumeratedArea: 95.75, plotArea: 150.0);
      cropAreaController.text = area.cropArea.toString();
      enumeratedAreaController.text = area.enumeratedArea.toString();
      areaData.value = area;
      isLoading.value = false;
    });
  }
  @override
  void onClose() {
    cropAreaController.dispose();
    enumeratedAreaController.dispose();
    super.onClose();
  }
}
class AreaModel {
  final double cropArea;
  final double enumeratedArea;
  final double plotArea; // ✅ required

  AreaModel({
    required this.cropArea,
    required this.enumeratedArea,
    required this.plotArea, // 👈 this is required
  });
}
