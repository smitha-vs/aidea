import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/zone_controller.dart';
class ZoneInfoCard extends StatelessWidget {
  final double? maxWidth;
   ZoneInfoCard({
    this.maxWidth,
    super.key,
  });
  final ZoneController controller = Get.put(ZoneController());
  @override
  Widget build(BuildContext context) {
    final zone = controller.data.value?.payload;
    final Map<String, String> zoneInfoMap = {
      "District": zone?.district ?? '',
      "Taluk": zone?.taluk ?? '',
      "Local Type": zone?.localType ?? '',
      "Zone Name": zone?.zoneName ?? '',
    };

    return Center(
      child: Container(
        width: maxWidth ?? double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFFfc6076), Color(0xFFff9a44)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1.2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: zoneInfoMap.entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on_rounded,
                            color: Colors.white.withOpacity(0.8),
                            size: 18),
                        const SizedBox(width: 8),
                        SizedBox(
                          width:  100,
                          child: Text(
                            "${e.key}:",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.9),
                              fontSize:  14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            e.value,
                            style: TextStyle(
                              fontSize:  14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
