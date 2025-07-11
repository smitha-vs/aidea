import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/cluster_label_area.dart';
import '../resources/constants/colours.dart';
import '../widget/crop_row.dart';
import '../widget/pop_up.dart';
class CropController extends GetxController {
  var cropList = <CropRow>[CropRow()].obs;
  void addCrop() {
    cropList.add(CropRow());
  }
  void removeCrop(int index) {
    if (cropList.length > 1) {
      cropList.removeAt(index);
    }
  }
}

class DirectionController extends GetxController {
  var selectedDirection = ''.obs;
  var availableDirections = <String>[].obs; // Will hold 'N', 'S', 'E', 'W'
  void loadDirectionsFromLabels(Labels labels) {
    availableDirections.clear();
    if (labels.n.isNotEmpty) availableDirections.add('N');
    if (labels.e.isNotEmpty) availableDirections.add('E');
    if (labels.s.isNotEmpty) availableDirections.add('S');
    if (labels.w.isNotEmpty) availableDirections.add('W');
    if (availableDirections.isNotEmpty) {
      selectedDirection.value = availableDirections.first;
    }
  }
  void setDirection(String direction) {
    if (selectedDirection.value != direction) {
      selectedDirection.value = direction;

      // Reset land data for the newly selected direction
      final landController = Get.find<LandCategoryController>();
      landController.resetAll();
    }
  }
  void updateDirection(String direction) {
    selectedDirection.value = direction;
  }
  String get fullDirection {
    switch (selectedDirection.value) {
      case 'N':
        return 'North';
      case 'S':
        return 'South';
      case 'E':
        return 'East';
      case 'W':
        return 'West';
      default:
        return '';
    }
  }
}

class PlotControllers extends GetxController {
  var clusterLabelArea = Rxn<ClusterLabelArea>(); // holds all label and area data
  var selectedDirection = ''.obs; // e.g., 'N', 'E', 'S', 'W'
  var selectedPlot = Rxn<E>(); // selected individual plot
  var newSidePlotNumber = ''.obs; // still usable if side plots are needed
  void loadClusterLabelArea(ClusterLabelArea data) {
    clusterLabelArea.value = data;
  }
  List<E> get plotsInSelectedDirection {
    final labels = clusterLabelArea.value?.labels;
    if (labels == null) return [];

    switch (selectedDirection.value) {
      case 'N':
        return labels.n;
      case 'E':
        return labels.e;
      case 'S':
        return labels.s;
      case 'W':
        return labels.w;
      default:
        return [];
    }
  }
  void selectPlot(E plot) {
    selectedPlot.value = plot;
  }

  // Add a plot to a direction
  void addPlot(String direction, E newPlot) {
    final labels = clusterLabelArea.value?.labels;
    if (labels == null) return;

    switch (direction) {
      case 'N':
        labels.n.add(newPlot);
        break;
      case 'E':
        labels.e.add(newPlot);
        break;
      case 'S':
        labels.s.add(newPlot);
        break;
      case 'W':
        labels.w.add(newPlot);
        break;
    }

    clusterLabelArea.refresh();
  }

  // Delete a plot from a direction
  void deletePlot(String direction, E plot) {
    final labels = clusterLabelArea.value?.labels;
    if (labels == null) return;

    switch (direction) {
      case 'N':
        labels.n.remove(plot);
        break;
      case 'E':
        labels.e.remove(plot);
        break;
      case 'S':
        labels.s.remove(plot);
        break;
      case 'W':
        labels.w.remove(plot);
        break;
    }

    clusterLabelArea.refresh();
    if (selectedPlot.value == plot) {
      selectedPlot.value = null;
    }
  }

  // Update an existing plot in a direction
  void updatePlot(String direction, int index, E updatedPlot) {
    final labels = clusterLabelArea.value?.labels;
    if (labels == null) return;

    switch (direction) {
      case 'N':
        labels.n[index] = updatedPlot;
        break;
      case 'E':
        labels.e[index] = updatedPlot;
        break;
      case 'S':
        labels.s[index] = updatedPlot;
        break;
      case 'W':
        labels.w[index] = updatedPlot;
        break;
    }

    clusterLabelArea.refresh();
  }
}
class LandCategoryController extends GetxController {
  late Map<String, RxString> totalValues;
  final RxDouble remainingArea = 0.0.obs;
  final List<String> categories = [
    'Building and Courtyard',
    'Other Non-Agricultural Uses',
    'Barren and Uncultivable Land',
    'Miscellaneous Tree Crops and Groves',
    'Permanent Pastures and Other Grazing Land',
    'Cultivable Waste',
    'Other Fallow',
    'Current Fallow',
    'Area under Social Forestry',
    'Waterlogged Area',
    'Still Water Land (Water bodies)',
    'Marshy Land',
    'Net Areas Sown',
  ];
  Map<String, String> getLandUtilizationDataForApi() {
    final Map<String, String> data = {
      "buildingArea": totalValues["Building and Courtyard"]?.value ?? '0.0',
      "nonAgriculturalArea": totalValues["Other Non-Agricultural Uses"]?.value ?? '0.0',
      "barrenArea": totalValues["Barren and Uncultivable Land"]?.value ?? '0.0',
      "miscellaneousTreesArea": totalValues["Miscellaneous Tree Crops and Groves"]?.value ?? '0.0',
      "permanentPasturesArea": totalValues["Permanent Pastures and Other Grazing Land"]?.value ?? '0.0',
      "cultivableWasteArea": totalValues["Cultivable Waste"]?.value ?? '0.0',
      "otherFallowArea": totalValues["Other Fallow"]?.value ?? '0.0',
      "currentFallowArea": totalValues["Current Fallow"]?.value ?? '0.0',
      "areaUnderSocialForestry": totalValues["Area under Social Forestry"]?.value ?? '0.0',
      "waterloggedArea": totalValues["Waterlogged Area"]?.value ?? '0.0',
      "stillWaterLand": totalValues["Still Water Land (Water bodies)"]?.value ?? '0.0',
      "marshyLand": totalValues["Marshy Land"]?.value ?? '0.0',
      "netAreasSown": totalValues["Net Areas Sown"]?.value ?? '0.0',
    };
    return data;
  }
  late Map<String, TextEditingController> totalControllers;
  late Map<String, TextEditingController> inputControllers;

  double totalDirectionArea = 0.0; // total area for current direction

  @override
  void onInit() {
    super.onInit();
    totalValues = {for (var cat in categories) cat: '0.0'.obs};
    totalControllers = {
      for (var cat in categories) cat: TextEditingController(text: "0.0")
    };
    inputControllers = {
      for (var cat in categories) cat: TextEditingController()
    };
    for (var cat in categories) {
      if (cat != 'Net Areas Sown') {
        inputControllers[cat]!.addListener(() {
          _updateNetAreaSown();
        });
      }
    }
  }
  void setDirectionArea(double area) {
    totalDirectionArea = area;
    _updateNetAreaSown();
  }
  void addToTotal(String category) {
    final input = inputControllers[category]!;
    final inputValue = double.tryParse(input.text) ?? 0.0;
    final currentTotal = double.tryParse(totalValues[category]!.value) ?? 0.0;
    if ((inputValue + _totalUsedExcluding(category)) > totalDirectionArea) {
      Get.snackbar(
        "Exceeds Area",
        "The entered value exceeds the total available area.",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    final newTotal = currentTotal + inputValue;
    totalValues[category]!.value = newTotal.toStringAsFixed(2);
    totalControllers[category]!.text = newTotal.toStringAsFixed(2);
    input.clear();

    if (category != 'Net Areas Sown') {
      _updateNetAreaSown();
    }
  }
  double _totalUsedExcluding(String excludeCategory) {
    double used = 0.0;
    for (var cat in categories) {
      if (cat != excludeCategory && cat != 'Net Areas Sown') {
        used += double.tryParse(totalValues[cat]?.value ?? '0') ?? 0.0;
      }
    }
    return used;
  }
  void _updateNetAreaSown() {
    double usedArea = 0.0;
    for (var cat in categories) {
      if (cat != 'Net Areas Sown') {
        final value = double.tryParse(totalValues[cat]?.value ?? '0') ?? 0.0;
        usedArea += value;
      }
    }
    final netArea = (totalDirectionArea - usedArea).clamp(0, totalDirectionArea);
    remainingArea.value = (totalDirectionArea - usedArea).clamp(0, double.infinity);
    totalValues['Net Areas Sown']!.value = netArea.toStringAsFixed(2);
    totalControllers['Net Areas Sown']!.text = netArea.toStringAsFixed(2);
  }
  @override
  void onClose() {
    for (var controller in totalControllers.values) {
      controller.dispose();
    }
    for (var controller in inputControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }
  void resetAll() {
    for (var cat in categories) {
      if (cat != 'Net Areas Sown') {
        totalValues[cat]!.value = '0.0';
        totalControllers[cat]!.text = '0.0';
        inputControllers[cat]!.clear();
      }
    }

    _updateNetAreaSown(); // reset Net Areas Sown
  }
}
class NUCTableController extends GetxController {
  late Map<String, RxString> totalValues;
  final List<String> categories = [
    'NUC',
    'FFC',
    'COS',
  ];
  late Map<String, TextEditingController> totalControllers;
  late Map<String, TextEditingController> inputControllers;

  @override
  void onInit() {
    super.onInit();
    totalValues = {
      for (var cat in categories) cat: '0.0'.obs
    };
    totalControllers = {
      for (var cat in categories) cat: TextEditingController(text: "0.0")
    };
    inputControllers = {
      for (var cat in categories) cat: TextEditingController()
    };
  }

  void addToTotal(String category) {
    final input = inputControllers[category]!;
    final inputValue = double.tryParse(input.text) ?? 0.0;
    final currentTotal = double.tryParse(totalValues[category]!.value) ?? 0.0;
    totalValues[category]!.value = (currentTotal + inputValue).toStringAsFixed(2);
    input.clear();
  }

  @override
  void onClose() {
    for (var controller in totalControllers.values) {
      controller.dispose();
    }
    for (var controller in inputControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }
}
