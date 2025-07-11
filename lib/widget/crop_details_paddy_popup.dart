import 'package:aidea/widget/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/crop_details_paddy.dart';
import 'cce_toggle_tab.dart';
void showCropSurveyPopup(
    BuildContext context,
    String cropName,
    String clusterNumber,
    void Function(double) onSaveArea,
    String direction,
    ) {
  final controller = Get.put(CropSurveyPopupController(direction), tag: direction);
  controller.rows.clear();
  controller.addRow();
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Crop: $cropName'),
          Text('Cluster No: $clusterNumber', style: const TextStyle(fontSize: 14)),
         // ToggleTabSwitch()
          Row(
            children: [
              Obx(() => Checkbox(
                value: controller.isIrrigated.value,
                onChanged: (val) {
                  controller.isIrrigated.value = true;
                },
              )),
              const Text("Irrigated"),
              const SizedBox(width: 20),
              Obx(() => Checkbox(
                value: !controller.isIrrigated.value,
                onChanged: (val) {
                  controller.isIrrigated.value = false;
                },
              )),
              const Text("Non-Irrigated"),
            ],
          ),
        ],
      ),
      content: Obx(() => SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              children: [
                Expanded(child: Text('Survey Number', style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(width: 10),
                Expanded(child: Text('Area (cents)', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            const SizedBox(height: 8),
            ...List.generate(controller.rows.length, (index) {
              final row = controller.rows[index];
              return Row(
                children: [
                  Expanded(
                    child: Obx(() => DropdownButtonFormField<String>(
                      value: row.selectedSurveyNo,
                      hint: const Text("Select"),
                      items: controller.surveyList
                          .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                          .toList(),
                      onChanged: (val) {
                        row.selectedSurveyNo = val;
                      },
                    )),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: row.areaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: "Enter area"),
                      onChanged: (_) => controller.recalculateTotalArea(),

                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => controller.removeRow(index),
                  )
                ],
              );
            }),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Add Row"),
              onPressed: controller.addRow,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Total Area: ${controller.totalArea.toStringAsFixed(2)} cents",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      )),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final totalArea = controller.totalArea;
            onSaveArea(totalArea.value);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
void showOtherCropPopup(
    BuildContext context, String cropName, String clusterId,String direction,void Function(double) onSaveArea,) {
  Get.dialog(
    CCECropDialog(cropName: cropName, clusterId: clusterId,direction:direction,onSaveArea: onSaveArea,),
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 300),
    transitionCurve: Curves.easeOutBack,
  );
}

void showCCEFormBottomSheet(
    BuildContext context,
    String cropName,
    String clusterId,
    String direction,
    void Function(double) onSaveArea,
    ) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return _AnimatedCCEForm(
            cropName: cropName,
            clusterId: clusterId,
            direction: direction,
            onSaveArea: onSaveArea,
            scrollController: scrollController,
          );
        },
      );
    },
  );
}
class _AnimatedCCEForm extends StatefulWidget {
  final String cropName;
  final String clusterId;
  final String direction;
  final Function(double) onSaveArea;
  final ScrollController scrollController;
  const _AnimatedCCEForm({
    required this.cropName,
    required this.clusterId,
    required this.direction,
    required this.onSaveArea,
    required this.scrollController,
  });

  @override
  State<_AnimatedCCEForm> createState() => _AnimatedCCEFormState();
}

class _AnimatedCCEFormState extends State<_AnimatedCCEForm>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: SingleChildScrollView(
          controller: widget.scrollController,
          padding: const EdgeInsets.all(16),
          child: PopUp(
            cropName: widget.cropName,
            clusterId: widget.clusterId,
            direction: widget.direction,
            onSaveArea: widget.onSaveArea,
          ),
        ),
      ),
    );
  }
}
class CCECropDialog extends StatelessWidget {
  final String cropName;
  final String clusterId;
  final String direction;
  final Function(double) onSaveArea;
  CCECropDialog({required this.cropName, required this.clusterId,required this.direction,required this.onSaveArea});
  final RxString apiMessage = 'Note: This is a CCE Crop.'.obs;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CropSurveyPopupController(direction), tag: direction);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.orange),
          const SizedBox(width: 8),
          Expanded(child: Text("CCE Check - $cropName")),
        ],
      ),
      content: Obx(() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children:[
              Icon(Icons.location_on, size: 20, color: Colors.blue),
              SizedBox(width: 4),
              Text("Cluster ID:$clusterId"),
            ],
          ),
          const SizedBox(height: 12),
          //ToggleTabSwitch(),
          Row(
            children: [
              Obx(() => Checkbox(
                value: controller.isIrrigated.value,
                onChanged: (val) {
                  controller.isIrrigated.value = true;
                },
              )),
              const Text("Irrigated"),
              const SizedBox(width: 20),
              Obx(() => Checkbox(
                value: !controller.isIrrigated.value,
                onChanged: (val) {
                  controller.isIrrigated.value = false;
                },
              )),
              const Text("Non-Irrigated"),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.redAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              apiMessage.value,
              style: const TextStyle(color: Colors.redAccent, fontSize: 14),
            ),
          ),
        ],
      )),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            showCCEFormBottomSheet(context, cropName, clusterId,direction,onSaveArea);
          },
          child: const Text("Accept"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Reject",style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}
