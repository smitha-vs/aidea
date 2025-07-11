import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/geo.dart';


class GpsLocation extends StatelessWidget {
  const GpsLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final GpsController controller = Get.put(GpsController());

    return Scaffold(
      appBar: AppBar(title: const Text('GPS Location')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: controller.getCurrentLocation,
              child: const Text("Get Current Location"),
            ),
            const SizedBox(height: 20),
            Obx(() => Text(controller.locationMessage.value)),
          ],
        ),
      ),
    );
  }
}
