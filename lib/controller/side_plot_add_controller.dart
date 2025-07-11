import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SurveyPopupController extends GetxController {
  var selectedVillage = ''.obs;
  var selectedBlock = ''.obs;
  var selectedSurvey = ''.obs;

  var villages = ['Village A', 'Village B'].obs;
  var blocks = <String>[].obs;
  var surveys = <String>[].obs;
  var relatedSurveys = <String>[].obs;

  var selectedRelatedSurveys = <String>{}.obs;

  void loadBlocks(String village) {
    // Mock data, ideally load from API
    blocks.value = village == 'Village A'
        ? ['Block A1', 'Block A2']
        : ['Block B1', 'Block B2'];
    selectedBlock.value = '';
  }

  void loadSurveys(String block) {
    surveys.value = block == 'Block A1'
        ? ['101', '102']
        : ['201', '202'];
    selectedSurvey.value = '';
  }

  void loadRelatedSurveys(String survey) {
    relatedSurveys.value = survey == '101'
        ? ['101-A', '101-B', '101-C']
        : ['202-A', '202-B'];
    selectedRelatedSurveys.clear();
  }

  void toggleRelatedSurvey(String survey) {
    if (selectedRelatedSurveys.contains(survey)) {
      selectedRelatedSurveys.remove(survey);
    } else {
      selectedRelatedSurveys.add(survey);
    }
  }
}
