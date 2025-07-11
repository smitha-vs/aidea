import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cluster.dart';
import '../../controller/cluster_info_card.dart';
import '../../controller/side_plot_add_controller.dart';
import '../../model/cluster_grid.dart';
import '../../model/cluster_label_area.dart';
import '../../model/cluster_model.dart';
import '../../resources/constants/colours.dart';
import '../../resources/constants/screen_responsive.dart';
import '../../widget/app_bar.dart';
import '../../widget/button.dart';
import '../../widget/crop_id_listing_dashboard.dart';
class ClusterDetailPage extends StatelessWidget {
  final ClusterPayload cluster = Get.arguments as ClusterPayload;
  final int displayIndex;
  ClusterDetailPage({super.key,required this.displayIndex,});
 final ClusterDetailController controller = Get.put(ClusterDetailController());
  final ClusterInfoCardEntry clusterInfoCardEntry = Get.put(ClusterInfoCardEntry());
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final clusterNumber =cluster.clusterNo;
    final localbody = cluster.localbody.toString().split('.').last.toUpperCase();
    final village = cluster.village.toString().split('.').last.toUpperCase();
    final block = cluster.blockcode;
    final surveyno=cluster.survyno;
    final status = cluster.clusterType;
    final totalArea = cluster.area.toString();
    Color getStatusColor(ClusterType clusterType) {
      return clusterType == ClusterType.WET ? Colors.green : Colors.red;
    }
    final bgColor = getStatusColor(cluster.clusterType);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(responsive.screenHeight * 0.07),
        child: Builder(
          builder:
              (context) => CustomAppBar(
                onMenuTap: () => Scaffold.of(context).openDrawer(),
                hideLeading: true,
                title: Padding(
                  padding: EdgeInsets.only(top: responsive.screenHeight * .025),
                  child: Text(
                    'CLUSTER',
                    style: TextStyle(
                      fontSize: responsive.screenWidth * 0.045,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
        ),
      ),
      body:
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20.0),
        child: Column(
          children: [
            _buildClusterInfoCard(
              clusterNumber.toString(),
              localbody.toString(),
              village.toString(),
              block,
              totalArea,
              status.toString(),
              surveyno, () => bgColor,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Obx(() => MyButton(
                    txt: 'EDIT',
                    height: 47,
                    color: controller.selectedButton.value == 'edit'
                        ? Colors.orangeAccent // Highlighted
                        : Colors.grey.shade400,
                    radius: 0,
                    onTap: controller.toggleEditMode,
                  )),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: MyButton(
                    color: AppColour.desBlueColor,
                    radius: 0,
                    txt: 'FORM 1',
                    height: 47,
                    onTap: () => Get.toNamed('/formDashboard'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: MyButton(
                    color: Colors.redAccent,
                    radius: 0,
                    txt: 'REJECT',
                    height: 47,
                    onTap: () {
                      Get.defaultDialog(
                        title: 'Reject',
                        middleText: 'Are you sure you want to reject this cluster?',
                        textConfirm: 'Yes',
                        textCancel: 'No',
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          Get.back();
                          Get.snackbar(
                            'Cluster Rejected',
                            'Cluster $clusterNumber has been rejected.',
                            backgroundColor: Colors.redAccent.withOpacity(0.8),
                            colorText: Colors.white,
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Obx(() => MyButton(
                    color: controller.selectedButton.value == 'crop'
                        ? Colors.blue
                        : Colors.green,
                    radius: 0,
                    txt: 'Crop',
                    height: 47,
                    onTap: controller.toggleClusterList,
                  )),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Obx(() => MyButton(
                    color: controller.selectedButton.value == 'remarks'
                        ? Colors.orangeAccent
                        : Colors.purpleAccent,
                    radius: 0,
                    txt: 'Remarks',
                    height: 47,
                    onTap: controller.toggleRemarksMode,
                  )),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Obx(() {
                if (controller.isEditMode.value) {
                  return _buildBoundarySurveyUI(context);
                } else if (controller.isCropList.value) {
                  return _buildCropSurveyUI();
                } else if (controller.isRemarksMode.value) {
                  return _buildRemarksSection();
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildClusterInfoCard(
      String clusterNumber,
      String localbody,
      String village,
      String block,
      String totalArea,
      String status,
      String surveyno,
      Color Function() getStatusColor,
      ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF4481eb), Color(0xFF04befe)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildInfoRow('Cluster Number:', clusterNumber),
                _buildInfoRow('Localbody:', localbody),
                _buildInfoRow('Village:', village),
                _buildInfoRow('Block Number:', block),
                _buildInfoRow('Total Area:', '$totalArea acres'),
                _buildInfoRow('Key Plot', surveyno,),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'Plot Type',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(
                    status.toString().split('.').last.toUpperCase(),
                    style: TextStyle(color: getStatusColor()),
                  ),
                  backgroundColor: getStatusColor().withOpacity(0.2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildInfoRow(String label, String value) {
    final bool isKeyPlot = label == 'Key Plot';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: isKeyPlot
          ? BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.yellowAccent, width: 1.5),
      )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: isKeyPlot ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          const SizedBox(width: 3),
          Text(
            value,
            style: TextStyle(
              fontSize: isKeyPlot ? 16 : 14,
              fontWeight: isKeyPlot ? FontWeight.bold : FontWeight.w500,
              color: isKeyPlot ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildBoundarySection(
      BuildContext context,
      String direction,
      List<TextEditingController> controllers,
      ) {
    final controller = Get.find<ClusterDetailController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          direction,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...controllers.map((ctrl) {
          return Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: ctrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                 controller.removePlotID(direction, ctrl);
                },
              )
            ],
          );
        }),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.newControllers[direction],
                decoration: const InputDecoration(
                  hintText: 'Add new survey no.',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.green),
              onPressed: () {
                showSurveyPopup(context);
                //controller.addSurveyNumber(direction);
              },
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildBoundarySurveyUI( BuildContext context) {
    final controller = Get.find<ClusterDetailController>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Side Plot Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...controller.boundaryControllers.keys.map((direction) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Obx(() => _buildBoundarySection(context,
                direction,
                controller.boundaryControllers[direction] ?? [],
              )),
            );
          }),
        ],
      ),
    );
  }
  Widget _buildCropSurveyUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Crop List',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: CropListingPopUp(
            onFormPressed: (Crop crop) {
              print("Navigate to Form1 for crop ID: ${crop.cropId}");
            },
          ),
        ),
      ],
    );
  }
  Widget _buildRemarksSection() {
    final remarksController = TextEditingController(); // You can move this to the controller if needed
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: 
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Remarks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: remarksController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write remarks here...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                onPressed: () {
                  // Handle saving remarks logic
                  print('Remarks saved: ${remarksController.text}');
                  Get.snackbar('Success', 'Remarks saved successfully');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  void showSurveyPopup(BuildContext context) {
    final controller = Get.put(SurveyPopupController());
    Get.defaultDialog(
      title: "Select Survey Info",
      content: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: controller.selectedVillage.value == '' ? null : controller.selectedVillage.value,
            hint: const Text("Select Village"),
            items: controller.villages.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
            onChanged: (val) {
              controller.selectedVillage.value = val!;
              controller.loadBlocks(val);
            },
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: controller.selectedBlock.value == '' ? null : controller.selectedBlock.value,
            hint: const Text("Select Block"),
            items: controller.blocks.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
            onChanged: (val) {
              controller.selectedBlock.value = val!;
              controller.loadSurveys(val);
            },
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: controller.selectedSurvey.value == '' ? null : controller.selectedSurvey.value,
            hint: const Text("Select Survey Number"),
            items: controller.surveys.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (val) {
              controller.selectedSurvey.value = val!;
              controller.loadRelatedSurveys(val);
            },
          ),
          const SizedBox(height: 8),
          if (controller.relatedSurveys.isNotEmpty)
            Wrap(
              spacing: 6.0,
              children: controller.relatedSurveys.map((related) {
                return Obx(() => FilterChip(
                  label: Text(related),
                  selected: controller.selectedRelatedSurveys.contains(related),
                  onSelected: (_) => controller.toggleRelatedSurvey(related),
                ));
              }).toList(),
            ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Get.back(); // close dialog
                // Optionally handle selected values here
                print("Selected: ${controller.selectedRelatedSurveys}");
              },
              child: const Text("Confirm"),
            ),
          ),
        ],
      )),
    );
  }

}
