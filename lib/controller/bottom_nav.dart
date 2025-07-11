import 'package:get/get.dart';
class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;
  void changeIndex(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
       // Get.offAll(() => const CropDetails());
        break;
      case 1:
      //  Get.offAll(() => const IrrigationDetails());
        break;
      case 2:
      ///  Get.offAll(() => const LandUtilization());
        break;
    }
  }
}
