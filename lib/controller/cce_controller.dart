import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class CategoryTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final tabs = ['Land Details', 'Crop Details', 'Irrigation', 'Yield Details'];
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }
  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
  var randomNumber = ''.obs;
  Future<void> fetchRandomNumber() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay
    randomNumber.value = _generateRandomNumber();
  }
  String _generateRandomNumber() {

    final rand = (100 + Random().nextInt(900)).toString(); // generates 100–999

    return "R-$rand";
  }

}
class ToggleTabController extends GetxController {
  final RxInt selectedIndex = 0.obs; // 0 = Irrigated, 1 = NonIrrigated

  // This gives the backend-friendly value
  bool get isIrrigated => selectedIndex.value == 0;

  void selectTab(int index) {
    selectedIndex.value = index;
  }
}


class TreeController extends GetxController {
  var big = ''.obs;
  var small = ''.obs;
  var total = ''.obs;

  final bigController = TextEditingController();
  final smallController = TextEditingController();

  void calculateTotal() {
    int b = int.tryParse(bigController.text) ?? 0;
    int s = int.tryParse(smallController.text) ?? 0;
    total.value = (b + s).toString();
  }

  @override
  void onClose() {
    bigController.dispose();
    smallController.dispose();
    super.onClose();
  }
}
class IrrigationController extends GetxController {
  var irrigationMethod = ''.obs;
  var fertilizerUsed = RxnBool(); // true/false/null
  var infected = RxnBool();
  var diseaseName = ''.obs;
  List<String> methods = ['Drip', 'Sprinkler', 'Flood', 'Manual'];
}
