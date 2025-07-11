import 'package:get/get.dart';

class SidebarController extends GetxController {
  var activeIndex = 0.obs;
  void setActiveIndex(int index) {
    activeIndex.value = index;
  }
}