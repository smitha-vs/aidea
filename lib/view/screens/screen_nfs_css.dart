import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controller/plot_details.dart';
import '../../widget/direction_selector.dart';
import '../../widget/nuc_table.dart';
import '../../widget/season.dart';
import 'land_utilization_table.dart';

class NFSValue extends StatelessWidget {
  const NFSValue({super.key});

  @override
  Widget build(BuildContext context) {
    final DirectionController directionController = Get.put(
      DirectionController(),
    );
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeasonCard(),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 4),
                child: Text(
                  'Select Direction (K = Keyplot, E = East, N = North, W = West,S = South)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              DirectionSelector(),
              const SizedBox(height: 20),
              Obx(() {
                final selected = directionController.selectedDirection.value;
                return selected.isNotEmpty
                    ? NUCTable(direction: selected)
                    : const SizedBox(); // Empty initially
              }),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildInputRow(BuildContext context, String label) {
    final width = MediaQuery.of(context).size.width;
    final textFieldWidth = width * 0.25;
    final remarksWidth = width * 0.4;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width * 0.15,
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          width: textFieldWidth,
          child: TextField(
            decoration: InputDecoration(
              labelText: "Area",
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: "Remarks",
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}
