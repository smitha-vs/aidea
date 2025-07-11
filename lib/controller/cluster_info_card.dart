import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cluster_grid.dart';
import '../model/cluster_info_card.dart';
import '../model/cluster_model.dart';
import '../resources/constants/path.dart';
import 'cluster.dart';
class ClusterInfoCardEntry extends GetxController {
  var isLoading = true.obs;
  var data = Rxn<ClusterInfoCard>(); // Holds the full response model
  final String apiUrl =clusterListUrl;
  final ClusterController controller = Get.put(ClusterController());
  @override
  void onInit() {
    controller.fetchClusterData();
    super.onInit();
  }
}