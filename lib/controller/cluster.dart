import 'dart:math';
import 'package:aidea/controller/plot_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cluster_grid.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/cluster_grid.dart';
import '../model/cluster_label_area.dart';
import '../model/cluster_model.dart';
import '../resources/constants/path.dart';
class ClusterController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxList<ClusterPayload> filteredClusters = <ClusterPayload>[].obs;
  RxList<ClusterPayload> allClusters = <ClusterPayload>[].obs;
  final RxSet<String> rejectedClusters = <String>{}.obs;
  final RxInt completed = 0.obs;
  final RxInt ongoing = 0.obs;
  final RxInt notStarted = 0.obs;
  final RxInt underReview = 0.obs;
  final Map<String, double> clusterProgress = {};
  var isLoading = true.obs;
  @override
  void onInit() async {
    super.onInit();
    fetchClusterData();
  }
  String normalizeStatus(String? status) {
    switch (status?.trim().toLowerCase()) {
      case 'completed':
        return 'Completed';
      case 'on going':
      case 'ongoing':
        return 'Ongoing';
      case 'not started':
        return 'Not Started';
      default:
        return 'Unknown';
    }
  }
  Future<void> fetchClusterData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final userID = await prefs.getString('userid');
    final String url = "$clusterListUrl/$userID";
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
        final ClusterList clusterList = ClusterList.fromJson(jsonData);
        completed.value = clusterList.completed;
        ongoing.value = clusterList.ongoing;
        notStarted.value = clusterList.notStarted;
        underReview.value=clusterList.underreview;
        final clusters = await Future.wait(
          clusterList.payload.map((c) async {
            final normalizedStatus = normalizeStatus(statusValues.reverse[c.status]!);
            final isWet = c.clusterType == ClusterType.WET;
            final clusterModel = ClusterPayload(
              clusterId: c.clusterId,
              keyplotId: c.keyplotId.toString(),
              village: c.village,
              survyno: c.survyno.toString(),
              blockcode: c.blockcode.toString(),
              area: c.area,
              localbody: c.localbody,
              status: c.status,
              clusterType: c.clusterType,
              cce:c.cce,
              clusterNo:c.clusterNo,
            );
            await prefs.setString('clusterNumber', clusterModel.clusterId.toString());
            clusterProgress[clusterModel.clusterId.toString()] = statusToProgress(
              normalizedStatus,
            );
            return clusterModel;
          }).toList(),
        );
        allClusters.value = clusters;
        filteredClusters.assignAll(clusters);
      } else {
        throw Exception('Failed to load clusters');
      }
    } catch (e) {
      print('Error fetching cluster data: $e');
    } finally {
      isLoading.value = false;
    }
  }
  void navigateToClusterForm(ClusterPayload cluster, int displayIndex) {
    Get.toNamed('/clusterDetailPage', arguments: cluster);
  }
  double getClusterProgress(String clusterNumber) {
    return clusterProgress[clusterNumber] ?? 0.0;
  }
  double statusToProgress(String status) {
    switch (status.trim().toLowerCase()) {
      case 'completed':
        return 1.0;
      case 'on going':
        return 0.5;
      case 'not started':
        return 0.0;
      default:
        return 0.0;
    }
  }
}
class ClusterDetailController extends GetxController {
  final isEditMode = false.obs;
  final isCropList = false.obs;
  final isLoading = false.obs;
  final selectedButton = ''.obs;
  var isRemarksMode = false.obs;//
  final data = Rxn<ClusterSidePlotData>();
  final boundaryControllers = <String, List<TextEditingController>>{}.obs;
  final newControllers = <String, TextEditingController>{}.obs;
  var cropIds = <int>[].obs;
  var crops = <Crop>[].obs;

  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
    if (isEditMode.value) {
      isCropList.value = false;
      selectedButton.value = 'edit';
    } else {
      selectedButton.value = '';
    }
  }
  void toggleClusterList() {
    isCropList.value = !isCropList.value;
    if (isCropList.value) {
      isEditMode.value = false;
      selectedButton.value = 'crop';
    } else {
      selectedButton.value = '';
    }
  }
  void toggleRemarksMode() {
    isEditMode.value = false;
    isCropList.value = false;
    isRemarksMode.value = true;
    selectedButton.value = 'remarks';
  }
  void addSurveyNumber(String direction) {
    final newValue = newControllers[direction]?.text.trim();
    if (newValue != null && newValue.isNotEmpty) {
      boundaryControllers[direction]?.add(
        TextEditingController(text: newValue),
      );
      newControllers[direction]?.clear();
      boundaryControllers.refresh();
    }
  }

  @override
  void onClose() {
    for (var list in boundaryControllers.values) {
      for (var controller in list) {
        controller.dispose();
      }
    }
    for (var controller in newControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }

  @override
  void onInit() {
    fetchSidePlots();
    super.onInit();
  }

  Future<void> fetchSidePlots() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final clusterNumber = await prefs.getString('clusterID');
    final String url = clusterSidePlots;
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({"clusterId": clusterNumber}),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final parsedData = ClusterSidePlotData.fromJson(jsonResponse);
        data.value = parsedData;
        crops.value = parsedData.crops;
        if (parsedData.crops.isNotEmpty) {
          crops.value = parsedData.crops;
          cropIds.value = parsedData.crops.map((crop) => crop.cropId).toList();
        }
        for (var controllers in boundaryControllers.values) {
          for (var controller in controllers) {
            controller.dispose();
          }
        }
        boundaryControllers.clear();
        if (data.value != null) {
          for (var entry in data.value!.labels.entries) {
            String direction = entry.key;
            List<DirectionLabel> plots = entry.value;
            boundaryControllers[direction] =
                plots
                    .map((plot) => TextEditingController(text: plot.svNo))
                    .toList();
          }
        }
        for (var entry in data.value!.labels.entries) {
          String direction = entry.key;
          newControllers.putIfAbsent(direction, () => TextEditingController());
        }
        boundaryControllers.refresh();
        newControllers.refresh();
      } else {
        Get.snackbar(
          "Error",
          "Failed to fetch side plots: ${response.statusCode}",
        );
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> removePlotID(
    String direction,
    TextEditingController ctrl,
  ) async {
    final svno = ctrl.text.trim();
    final clusterId = data.value?.clusterId;
    if (clusterId == null || svno.isEmpty) {
      Get.snackbar("Error", "Missing cluster ID or survey number");
      return;
    }
    final directionLabels = data.value?.labels[direction];
    DirectionLabel? matchedPlot;
    try {
      matchedPlot = directionLabels?.firstWhere((plot) => plot.svNo == svno);
    } catch (_) {
      matchedPlot = null;
    }
    if (matchedPlot == null) {
      Get.snackbar("Error", "Matching plot not found for $svno");
      return;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final response = await http.post(
        Uri.parse(removePlots),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({"cluster_plot_id": matchedPlot.clusterPlotId}),
      );
      if (response.statusCode == 200) {
        boundaryControllers[direction]?.remove(ctrl);
        ctrl.dispose();
        boundaryControllers.refresh();
        Get.snackbar("Success", "Survey number $svno deleted");
      } else {
        Get.snackbar("Error", "Failed to delete survey number from database");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    }
  }
}
