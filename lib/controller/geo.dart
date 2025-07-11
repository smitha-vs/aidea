import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class GpsController extends GetxController {
  var locationMessage = 'Current Location of the user'.obs;
  var lat = ''.obs;
  var long = ''.obs;

  @override
  void onInit() {
    super.onInit();
    requestPermissionAtStart();
  }

  Future<void> requestPermissionAtStart() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationMessage.value = 'Location services are disabled';
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        locationMessage.value = 'Location permission denied';
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      locationMessage.value =
      'Location permissions are permanently denied.';
      return;
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      lat.value = position.latitude.toString();
      long.value = position.longitude.toString();
      locationMessage.value = 'Latitude: ${lat.value}, Longitude: ${long.value}';
    } catch (e) {
      locationMessage.value = 'Error: $e';
    }
  }
}
