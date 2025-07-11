import 'package:get/get.dart';
import 'package:intl/intl.dart';
class SeasonController extends GetxController {
  var selectedDates = DateTime.now().obs;
  var selectedMonth = ''.obs;
  var selectedSeason = ''.obs;
  var selectedVisit = ''.obs;
  var selectedDate = Rxn<DateTime>();
  final List<String> seasons = ['Autumn', 'Winter', 'Summer'];
  @override
  void onInit() {
    super.onInit();
    setFromDate(selectedDates.value);
  }
  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }
  void setFromDate(DateTime date) {
    selectedDate.value = date;
    selectedMonth.value = DateFormat.MMMM().format(date);
    selectedSeason.value = getCurrentSeason(date);
    selectedVisit.value = getVisitLabel(selectedSeason.value);
  }

  String getCurrentSeason(DateTime date) {
    final month = date.month;
    if (month >= 7 && month <= 10) return "Autumn";
    if (month == 11 || month == 12) return "Winter";
    return "Summer";
  }

  String getVisitLabel(String season) {
    switch (season) {
      case "Autumn":
        return "1st Visit";
      case "Winter":
        return "2nd Visit";
      case "Summer":
        return "3rd Visit";
      default:
        return "";
    }
  }

  void setSeason(String season) {
    selectedSeason.value = season;
    selectedVisit.value = getVisitLabel(season);
  }
}
