import 'package:aidea/model/cluster_model.dart';
import 'package:aidea/widget/shimmer_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/cluster.dart';
import '../model/cluster_grid.dart';
import 'legend_box.dart';
class ClusterGridPage extends StatelessWidget {
  const ClusterGridPage({super.key});
  Future<void> saveClusterIdToPrefs(String clusterId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedClusterId', clusterId);
  }
  @override
  Widget build(BuildContext context) {
    final ClusterController controller = Get.find<ClusterController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = _getCrossAxisCount(screenWidth);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            final completed = controller.completed.value;
            final ongoing = controller.ongoing.value;
            final notStarted = controller.notStarted.value;
            final underReview = controller.underReview.value;
            final total = completed + ongoing + notStarted;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cluster Progress Summary", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _statusBox('Completed', completed, Colors.blue.shade400),
                    _statusBox('Ongoing', ongoing, Colors.orange),
                    _statusBox('Not Started', notStarted, Colors.grey),
                    _statusBox('Under Review', underReview, Colors.purpleAccent),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            );
          }),
          const SizedBox(height: 20),
          Row(
            children: [
              LegendBox(color: Colors.green.shade100, label: 'Wet Cluster'),
              const SizedBox(width: 16),
              LegendBox(color: Colors.red.shade100, label: 'Dry Cluster'),
            ],
          ),
          const SizedBox(height: 20),
    Expanded(
            child: Obx(() {
    if (controller.isLoading.value) {
    return const ShimmerList();
    }
    return GridView.builder(
              itemCount: controller.filteredClusters.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 1,
              ),
                itemBuilder: (context, index) {
                  final cluster = controller.filteredClusters[index];
                  return ClusterCard(
                    cluster: cluster,
                    displayIndex: cluster.clusterNo,
                      onTap: () async {
                        await saveClusterIdToPrefs(cluster.clusterId.toString()); // assuming cluster.clusterNumber is the ID
                        controller.navigateToClusterForm(cluster,cluster.clusterNo);
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('clusterID', cluster.clusterId.toString());
                      }
                  );
                }
            );
    }
          ),
    )],
      ),
    );
  }
  Widget _statusBox(String label, int count, Color color) {
    IconData statusIcon;
    switch (label.toLowerCase()) {
      case 'completed':
        statusIcon = Icons.check_circle;
        break;
      case 'ongoing':
        statusIcon = Icons.access_time;
        break;
      case 'not started':
        statusIcon = Icons.remove_circle_outline;
        break;
      case 'under review':
        statusIcon = Icons.rate_review;
        break;
      default:
        statusIcon = Icons.info_outline;
    }
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 12), // give space for icon
                Text(
                  '$count',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
                ),
                Text(
                  label,
                  style: TextStyle(color: color, fontWeight: FontWeight.w500,fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // Positioned icon
            Positioned(
              top: 0,
              right: 0,
              child: Icon(
                statusIcon,
                color: color,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
  int _getCrossAxisCount(double width) {
    if (width >= 1200) return 6;
    if (width >= 900) return 5;
    if (width >= 700) return 4;
    if (width >= 500) return 6;
    return 2;
  }
}
class ClusterCard extends StatelessWidget {
  final ClusterPayload cluster;
  final VoidCallback onTap;
  final int displayIndex;
  const ClusterCard({
    super.key,
    required this.cluster,
    required this.onTap,
    required this.displayIndex,
  });
  @override
  Widget build(BuildContext context) {
    final isWet = cluster.clusterType == ClusterType.WET;
    final bgColor = isWet ? Colors.green.shade100 : Colors.red.shade100;
    final borderColor = isWet ? Colors.green.shade700 : Colors.red.shade700;
    Color statusColor;
    IconData statusIcon;
    switch (cluster.status) {
      case Status.NOT_STARTED:
        statusColor = Colors.grey;
        statusIcon = Icons.remove_circle_outline;
        break;
      case Status.ON_GOING:
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
        break;
      case Status.UNDER_REVIEW:
        statusColor = Colors.purpleAccent;
        statusIcon = Icons.reviews;
        break;
      case Status.COMPLETED:
        statusColor = Colors.blue;
        statusIcon = Icons.check_circle;
      }
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
              ),
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '$displayIndex',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          // 🔹 Status Badge (top-right corner)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(4),
              child: Icon(
                statusIcon,
                color: Colors.white,
                size: 5,
              ),
            ),
          ),
          if (cluster.cce)
            Positioned(
              bottom: 6,
              left: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'c',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

}
