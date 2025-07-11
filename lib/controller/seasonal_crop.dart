import 'package:get/get.dart';
import 'package:get/get.dart';

class CropTypeController extends GetxController {
  RxString selectedCropType = 'Annual'.obs;
  var selectedDate = Rxn<DateTime>(); // Nullable Rx<DateTime>
  void setCropType(String? value) {
    if (value != null) {
      selectedCropType.value = value;
    }
  }
  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }
}
