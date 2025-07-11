import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

import '../../../../controller/cce/preharvest/cult_details.dart';

class CultivationDetailsPage extends StatelessWidget {
  final controller = Get.put(CultivationController());
 CultivationDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Cultivation Details')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(media.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Crop Name
            Text("Crop Name", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              onChanged: (val) => controller.cropName.value = val,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Crop Name",
              ),
            ),
            SizedBox(height: 20),

            // No of Patches and Random Patch
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Row(
                children: [
                  // No. of Patches
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("No of Patches", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        TextField(
                          controller: controller.numOfPatchesController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter number",
                          ),
                          onChanged: (val) {
                            controller.numOfPatches.value = int.tryParse(val) ?? 0;
                            controller.selectedPatch.value = null; // reset selected patch
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  // Random Patch Generator
                  Expanded(
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Selected Patch", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        controller.selectedPatch.value == null
                            ? ElevatedButton(
                          onPressed: controller.generateRandomPatch,
                          child: Text("Generate"),
                        )
                            : Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green.shade100,
                          ),
                          child: Center(
                            child: Text(
                              "Patch ${controller.selectedPatch.value}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Cultivated Area
            Text("Cultivated Area", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: controller.areaController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter area in acres/hectares",
              ),
              onChanged: (val) => controller.cultivatedArea.value = val,
            ),
            SizedBox(height: 20),

            // Expected Date
            Text("Expected Date", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Obx(() => InkWell(
              onTap: () => controller.pickDate(context),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  controller.expectedDate.value == null
                      ? "Select Date"
                      : DateFormat('dd MMM yyyy').format(controller.expectedDate.value!),
                  style: TextStyle(
                    color: controller.expectedDate.value == null ? Colors.grey : Colors.black,
                  ),
                ),
              ),
            )),
            SizedBox(height: 40),
            // Captured Image Preview
            Obx(() {
              if (controller.capturedImage.value != null) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Captured Image", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          controller.capturedImage.value!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _bottomButton(icon: Icons.camera_alt, label: "Capture Image", onTap: controller.captureImage),
                _bottomButton(icon: Icons.note_alt_outlined, label: "Remarks", onTap: () {}),
                _bottomButton(icon: Icons.save, label: "Save", onTap: () {
                  Get.snackbar("Saved", "Cultivation details saved successfully",
                      backgroundColor: Colors.green.shade100,
                      snackPosition: SnackPosition.BOTTOM);
                }),
              ],
            ),
            SizedBox(height: 20),
            Text("Draw Field Layout", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Container(
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Signature(
                controller: controller.signatureController,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.refresh),
                  label: Text("Clear Drawing"),
                  onPressed: () => controller.signatureController.clear(),
                ),
                SizedBox(width: 12),
                ElevatedButton.icon(
                  icon: Icon(Icons.download),
                  label: Text("Export Drawing"),
                  onPressed: () async {
                    final image = await controller.signatureController.toPngBytes();
                    if (image != null) {
                      Get.snackbar("Drawing Exported", "Sketch saved to memory",
                          backgroundColor: Colors.green.shade100);
                      // You can save to file or attach in save logic
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  Widget _bottomButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.green.shade200,
            child: Icon(icon, color: Colors.white),
          ),
        ),
        SizedBox(height: 6),
        Text(label),
      ],
    );
  }
}
