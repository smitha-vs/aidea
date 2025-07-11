import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/plot_details.dart';
import '../resources/constants/colours.dart';
import '../resources/constants/screen_responsive.dart';
import 'button.dart';

class NUCTable extends StatelessWidget {
  final String direction;

   NUCTable({super.key, required this.direction});
  final Map<String, TextEditingController> remarksControllers = {
    'NUC': TextEditingController(),
    'FFC': TextEditingController(),
    'COS': TextEditingController(),
  };
  @override
  Widget build(BuildContext context) {
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    final NUCTableController controller = Get.put(NUCTableController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Table(
          border: TableBorder.all(color: Colors.black),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: const BoxDecoration(color: Colors.black12),
              children: [
                _headerCell(context, 'Category'),
                _headerCell(context, 'Area (in cents)'),
              ],
            ),
            ...controller.categories.map(
                  (category) =>
                  TableRow(
                    children: [
                      _tableCell(context, category),
                      _areaInputFields(context, controller, category),
                    ],
                  ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: MyButton(
            txt: 'SUBMIT',
            color: AppColour.desBlueColor,
            radius: 0,
            height: responsive.screenHeight * 0.06,
            width: responsive.screenWidth * 0.5,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _headerCell(BuildContext context, String text) {
    final responsive = ResponsiveHelper(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade700,
            Colors.blue.shade400,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.all(responsive.screenWidth * 0.02),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: responsive.screenWidth * 0.03,
          color: Colors.white, // White text
        ),
      ),
    );
  }

  Widget _tableCell(BuildContext context, String category) {
    final responsive = ResponsiveHelper(context);
    const targetCategories = ['NUC', 'FFC', 'COS'];
    return Padding(
      padding: EdgeInsets.all(responsive.screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: TextStyle(fontSize: responsive.screenWidth * 0.035),
          ),
          if (targetCategories.contains(category)) ...[
            const SizedBox(height: 8),
            TextField(
              controller: remarksControllers[category],
              decoration: const InputDecoration(
                labelText: 'Remarks',
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _areaInputFields(BuildContext context,
      NUCTableController controller,
      String category,) {
    final responsive = ResponsiveHelper(context);
    return Padding(
      padding: EdgeInsets.all(responsive.screenWidth * 0.02),
      child: Obx(() {
        final total = controller.totalValues[category]!.value;
        return Column(
          children: [
            TextField(
              controller: TextEditingController(text: total)
                ..selection = TextSelection.fromPosition(
                  TextPosition(offset: total.length),
                ),
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Total Area',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.inputControllers[category],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Area',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => controller.addToTotal(category),
            ),
          ],
        );
      }),
    );
  }
}