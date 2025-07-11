import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cluster.dart';
import '../../resources/constants/screen_responsive.dart';
import '../../widget/app_bar.dart';
import '../../widget/cluster_grid.dart';

class ClusterViewPage extends StatelessWidget {
  ClusterViewPage({super.key});

  final ClusterController controller = Get.put(ClusterController());

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(responsive.screenHeight * 0.07),
        child: CustomAppBar(
          onMenuTap: () => Scaffold.of(context).openDrawer(),
          hideLeading: true,
          title: Padding(
            padding: EdgeInsets.only(top: responsive.screenHeight * 0.02),
            child: Text(
              'CLUSTER-LIST',
              style: TextStyle(
                fontSize: responsive.screenWidth * 0.045,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: ClusterGridPage(),
      ),
    );
  }
}
