import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cluster.dart';
import '../controller/plot_details.dart';
class DirectionSelectorToggle extends StatelessWidget {
  DirectionSelectorToggle({super.key});
  final DirectionController directionController = Get.put(DirectionController());
  final ClusterDetailController sidePlotController = Get.put(ClusterDetailController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final labels = sidePlotController.data.value?.labels;
      final totalAreaMap = sidePlotController.data.value?.totalArea ?? {};
      final directions = <String>[];
      if (labels != null) {
        labels.forEach((key, value) {
          if (value.isNotEmpty) directions.add(key);
        });
      }
      if (directions.isNotEmpty &&
          directionController.selectedDirection.value.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          directionController.setDirection(directions.first);
        });
      }
      if (directions.isEmpty) {
        return const SizedBox();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.info, color: Colors.blue),
                onPressed: () {
                  final selected = directionController.selectedDirection.value;
                  if (selected.isNotEmpty) {
                    showSurveyNumberPopup(context, selected);
                  } else {
                    Get.snackbar("No Direction Selected", "Please select a direction first.");
                  }
                },
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: directions.map((direction) {
                final isSelected = directionController.selectedDirection.value == direction;
                final area = totalAreaMap[direction] ?? 0.0;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => directionController.setDirection(direction),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.white,
                        borderRadius: _getBorderRadius(direction, directions),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            _getDisplayName(direction),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${area.toStringAsFixed(2)}cents",
                            style: TextStyle(
                              fontSize: 10,
                              color: isSelected ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Direction toggle UI
        ],
      );
    });
  }
  String _getDisplayName(String dir) {
    switch (dir.toUpperCase()) {
      case 'N':
        return 'N';
      case 'S':
        return 'S';
      case 'E':
        return 'E';
      case 'W':
        return 'W';
      default:
        return dir;
    }
  }
  BorderRadius? _getBorderRadius(String direction, List<String> directions) {
    if (direction == directions.first) {
      return const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      );
    } else if (direction == directions.last) {
      return const BorderRadius.only(
        topRight: Radius.circular(12),
        bottomRight: Radius.circular(12),
      );
    }
    return null;
  }
  void showSurveyNumberPopup(BuildContext context, String direction) {
    final plots = sidePlotController.data.value?.labels[direction] ?? [];
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Survey Numbers - $direction'),
        content: plots.isNotEmpty
            ? SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: plots.length,
            itemBuilder: (context, index) {
              final plot = plots[index];
              return ListTile(
                leading: const Icon(Icons.location_on, color: Colors.green),
                title: Text('SV No: ${plot.svNo}'),
                subtitle: Text('Area: ${plot.area.toStringAsFixed(2)} cents'),
              );
            },
          ),
        )
            : const Text('No survey numbers found.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
