import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SeasonVisitWidget extends StatelessWidget {
  const SeasonVisitWidget({super.key});
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String monthName = DateFormat.MMMM().format(now); // e.g., "May"
    String season = getCurrentSeason(now);
    int visitNumber = getVisitNumber(season);
    return Scaffold(
      appBar: AppBar(title: Text("Seasonal Visit")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Current Month: $monthName", style: TextStyle(fontSize: 18)),
            Text("Season: $season", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Visit Number: $visitNumber", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
  String getCurrentSeason(DateTime date) {
    final month = date.month;
    if (month >= 7 && month <= 10) {
      return "Autumn";
    } else if (month == 11 || month == 12) {
      return "Winter";
    } else {
      return "Summer";
    }
  }

  int getVisitNumber(String season) {
    switch (season) {
      case "Autumn":
        return 1;
      case "Winter":
        return 2;
      case "Summer":
        return 3;
      default:
        return 0;
    }
  }
}
