import 'package:aidea/view/screens/screen_sheme_earas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DashboardController extends GetxController {
  var allowedModules = <ModuleItem>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchAllowedModules(); // Simulate API call
  }
  void fetchAllowedModules() {
    var dataFromAPI = [
      ModuleItem(
        title: "EARAS",
        imagePath: 'assets/icons/earas.png',
        onTap: () {
          Get.to(() => ScreenEarasExt());
        },
      ),
      ModuleItem(title: "Price", imagePath: 'assets/icons/best-price.png'),
      ModuleItem(
        title: "Labour & Housing",
        imagePath: 'assets/icons/labour.png',
      ),
      ModuleItem(title: "IIP", imagePath: 'assets/icons/iip.png'),
      ModuleItem(title: "MCCD", imagePath: 'assets/icons/mccd.png'),
      ModuleItem(
        title: "Cultivation Cost",
        imagePath: 'assets/icons/costcult.png',
      ),
      ModuleItem(title: "Soil Eval.", imagePath: 'assets/icons/soil.png'),
      ModuleItem(
        title: "Statistics",
        imagePath: 'assets/icons/localstatistics.png',
      ),
      ModuleItem(
        title: "Civil Reg.",
        imagePath: 'assets/icons/registration.png',
      ),
    ];
    allowedModules.value = dataFromAPI; // Or filter based on login
  }
}

class ModuleItem {
  final String title;
  final String imagePath;
  final Function()? onTap;

  ModuleItem({required this.title, required this.imagePath, this.onTap});
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    final media = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 700 && screenWidth < 1024;
    final isLarge = media.width > 900;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        return GridView.builder(
          itemCount: controller.allowedModules.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isLarge ? 4 : (isTablet ? 4 : 3),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isLarge
                ? 1.3
                : (isTablet ? 1.1 : 0.95), // Adjusts height/width ratio
          ),
          itemBuilder: (context, index) {
            final item = controller.allowedModules[index];
            return GestureDetector(
              onTap: item.onTap,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6f86d6), Color(0xFF48c6ef)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        item.imagePath,
                        width: isLarge ? 60 : (isTablet ? 50 : 40),
                        height: isLarge ? 60 : (isTablet ? 50 : 40),
                        color: Colors.white,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isLarge ? 18 : (isTablet ? 16 : 14),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

