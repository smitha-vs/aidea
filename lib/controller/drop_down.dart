import 'package:get/get.dart';

class DropdownController extends GetxController {
  var selectedCrop = ''.obs;

  void setCrop(String value) {
    selectedCrop.value = value;
  }
}
