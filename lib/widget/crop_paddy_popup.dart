import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/crop_paddy_popup.dart';
import '../controller/pop_up_date.dart';


class SurveyPopupScreen extends StatelessWidget {
  final Map<String, dynamic> cropData;
  SurveyPopupScreen({super.key, required this.cropData});

  final SurveyController controller = Get.put(SurveyController());
  final PopUpDate datecontroller = Get.put(PopUpDate());
  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Crop Name: ${cropData['crop_name']}"),
              const SizedBox(height: 10),
              Text("Cluster Number: ${cropData['clusterId']}"),
              const SizedBox(height: 20),
              // const Text("Expected Date", style: TextStyle(fontSize: 15)),
              // const SizedBox(height: 8),
              // Obx(() => InkWell(
              //   onTap: () => datecontroller.pickDate(context),
              //   child: Container(
              //     width: double.infinity,
              //     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Colors.grey.shade400),
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: Text(
              //       datecontroller.expectedDate.value == null
              //           ? "Select Date"
              //           : DateFormat('dd MMM yyyy')
              //           .format(datecontroller.expectedDate.value!),
              //       style: TextStyle(
              //         color: datecontroller.expectedDate.value == null
              //             ? Colors.grey
              //             : Colors.black,
              //       ),
              //     ),
              //   ),
              // )),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Survey Area'),
                onPressed: () => showSurveyDialog(context, isWide),
              ),
              const SizedBox(height: 20),
              Obx(() => Column(
                children: controller.addedList.map((item) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text('Survey No: ${item['survey']}'),
                      subtitle: Text('Area: ${item['area']}'),
                    ),
                  );
                }).toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void showSurveyDialog(BuildContext context, bool isWide) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Survey Area'),
        content: SizedBox(
          width: isWide ? 400 : double.infinity,
          child: Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration:
                const InputDecoration(labelText: 'Select Survey Number'),
                value: controller.selectedSurvey.value.isNotEmpty
                    ? controller.selectedSurvey.value
                    : null,
                items: controller.surveyList
                    .map((survey) => DropdownMenuItem(
                  value: survey,
                  child: Text(survey),
                ))
                    .toList(),
                onChanged: (value) =>
                controller.selectedSurvey.value = value ?? '',
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller.areaController,
                decoration: const InputDecoration(labelText: 'Enter Area'),
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          )),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: controller.addSurveyData,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
