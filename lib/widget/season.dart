import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/season.dart';
import '../controller/seasonal_crop.dart';
import '../resources/constants/screen_responsive.dart';
class SeasonCard extends StatelessWidget {
  const SeasonCard({super.key});
  @override
  Widget build(BuildContext context) {
    final SeasonController controller = Get.put(SeasonController());
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // buildDatePickerTag(context, () async {
          //   DateTime? picked = await showDatePicker(
          //     context: context,
          //     initialDate: DateTime.now(),
          //     firstDate: DateTime(2020),
          //     lastDate: DateTime(2100),
          //     builder: (context, child) {
          //       return Theme(
          //         data: ThemeData.light().copyWith(
          //           colorScheme: const ColorScheme.light(
          //             primary: Colors.blue,
          //             onPrimary: Colors.white,
          //             onSurface: Colors.blue,
          //           ),
          //           textButtonTheme: TextButtonThemeData(
          //             style: TextButton.styleFrom(foregroundColor: Colors.blue),
          //           ),
          //         ),
          //         child: child!,
          //       );
          //     },
          //   );
          //   if (picked != null) {
          //     controller.setSelectedDate(picked); // update date
          //   }
          // }, Colors.blue),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: controller.seasons.map((season) {
              return _buildRadioOption(
                controller,
                season,
                Colors.orange,
              );
            }).toList(),
          ),
        ],
      )),
    );
  }
  Widget _buildRadioOption(
      SeasonController controller, String value, Color borderColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: borderColor.withOpacity(0.15),
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: value,
            groupValue: controller.selectedSeason.value,
            activeColor: borderColor,
            onChanged: (val) {
              controller.setSeason(val!);
            },
          ),
          Text(
            value,
            style: TextStyle(color: borderColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
  Widget buildDatePickerTag(
      BuildContext context,
      VoidCallback onTap,
      Color borderColor,
      ) {
    final SeasonController controller = Get.find();
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Obx(() {
        final date = controller.selectedDate.value;
        final formattedDate =
        date != null
            ? "${_getMonthName(date.month)}, ${date.day} - ${_getWeekdayName(date.weekday)}"
            : "Select Date";
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.calendar_today, size: 25, color: Colors.black),
              const SizedBox(width: 6),
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  String _getMonthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month];
  }

  String _getWeekdayName(int weekday) {
    const weekdays = [
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return weekdays[weekday];
  }
}
