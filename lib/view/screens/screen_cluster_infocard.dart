import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cluster_info_card.dart';
import '../../model/cluster_info_card.dart';

class ScreenClusterInfocard extends StatelessWidget {
  ScreenClusterInfocard({super.key});
  final ClusterInfoCard cluster = Get.arguments as ClusterInfoCard;
  ClusterInfoCardEntry controller = Get.put(ClusterInfoCardEntry());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cluster Info")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final clusterInfo = controller.data.value;
        if (clusterInfo == null || clusterInfo.payload.isEmpty) {
          return const Center(child: Text("No cluster data available"));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: clusterInfo.payload.length,
          itemBuilder: (context, index) {
            final item = clusterInfo.payload[index];
            return _buildClusterInfoCard(
              item.clusterId.toString(),          // Cluster Number
              item.localbody.name,               // Localbody
              item.village.name,                 // Village
              item.blockcode,                    // Block
              item.area.toStringAsFixed(2),      // Total Area
              item.status.name.replaceAll("_", " "), // Status
              item.survyno,                      // Survey No
                  () => _getStatusColor(item.status), // ✅ Corrected: Pass a function
            );
          },
        );
      }),
    );
  }
  Color _getStatusColor(Status status) {
    switch (status) {
      case Status.NOT_STARTED:
        return Colors.red;
      case Status.ON_GOING:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
  Widget _buildClusterInfoCard(
    String clusterNumber,
    String localbody,
    String village,
    String block,
    String totalArea,
    String status,
    String surveyno,
    Color Function() getStatusColor,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF4481eb), Color(0xFF04befe)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildInfoRow('Cluster Number', clusterNumber),
                _buildInfoRow('localbody', localbody),
                _buildInfoRow('', village),
                _buildInfoRow('Block Number', block),
                _buildInfoRow('Total Area', '$totalArea acres'),
                _buildInfoRow('Key Plot', surveyno),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'Status:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(
                    status.toUpperCase(),
                    style: TextStyle(color: getStatusColor()),
                  ),
                  backgroundColor: getStatusColor().withOpacity(0.2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
Widget _buildInfoRow(String label, String value) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        '$label: ',
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
      Text(
        value,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ],
  );
}
