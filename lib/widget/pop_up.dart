import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/crop_details_paddy.dart';
import '../controller/pop_up_date.dart';
import 'package:intl/intl.dart'; // For formatting date
class PopUp extends StatelessWidget {
  final String cropName;
  final String clusterId;
  final String direction;
  final void Function(double) onSaveArea;
   PopUp({super.key, required this.cropName, required this.clusterId,required this.direction, required this.onSaveArea,});
  final PopUpDate controller = Get.put(PopUpDate());
  @override
  Widget build(BuildContext context) {
    final surveyController = Get.put(CropSurveyPopupController(direction), tag: direction);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 600;
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Crop Name: $cropName",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text("Cluster Number: $clusterId",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.grey.shade700,
                      )),
                  const SizedBox(height: 20),
                  const SizedBox(height: 8),
                  Obx(() => InkWell(
                    onTap: () => controller.pickDate(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        controller.expectedDate.value == null
                            ? "Select Date"
                            : DateFormat('dd MMM yyyy').format(
                            controller.expectedDate.value!),
                        style: TextStyle(
                          color: controller.expectedDate.value == null
                              ? Colors.grey
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(height: 16),
                  Obx(() => DropdownButtonFormField<String>(
                    value: surveyController.selectedSurveyNo.value,
                    hint: const Text("Select Survey Number"),
                    items: surveyController.surveyList
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (val) {
                      surveyController.selectedSurveyNo.value = val;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                  )),
                  const SizedBox(height: 16),
                  _buildInputField("Cultivated Area", controller.areaController, keyboardType: TextInputType.number),
                  _buildInputField("Farmer Name", controller.farmerNameController),
                  _buildInputField("Address",controller. addressController, maxLines: 2),
                  _buildInputField("Mobile Number",controller. mobileController, keyboardType: TextInputType.phone),
                  _buildInputField("Remarks", controller.remarksController, maxLines: 2),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: isWideScreen ? 200 : double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final area = double.tryParse(controller.areaController.text) ?? 0.0;
                          onSaveArea(area);
                          controller.clearFields();// ✅ Send value back
                          Navigator.of(context).pop();
                        } ,
                        label: const Text("SAVE",style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget _buildInputField(String label,TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1,}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        keyboardType: keyboardType,
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        ),
      ),
    );
  }
}
