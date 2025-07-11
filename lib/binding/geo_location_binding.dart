import 'package:get/get.dart';
import '../controller/geo.dart';
class GpsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GpsController>(() => GpsController());
  }
}
