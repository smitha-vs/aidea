import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cluster.dart';
import '../model/cluster_label_area.dart';
class CropListingPopUp extends StatelessWidget {
  final void Function(Crop crop)? onFormPressed;
  const CropListingPopUp({super.key, this.onFormPressed});
  @override
  Widget build(BuildContext context) {
    final ClusterDetailController controller = Get.put(ClusterDetailController());
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.crops.isEmpty) {
        return const Center(child: Text("No crops available"));
      }
      return ListView.builder(
        itemCount: controller.crops.length,
        itemBuilder: (context, index) {
          final crop = controller.crops[index];
          return Card(
            child: ListTile(
              title: Text(crop.cropName),
              onTap: () => onFormPressed?.call(crop),
            ),
          );
        },
      );
    });
  }
}
