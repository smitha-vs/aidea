import 'package:flutter/material.dart';

import '../resources/constants/screen_responsive.dart';
import '../view/screens/screen_sheme_earas.dart';
import '../view/screens/screen_aidea_schemes.dart';

class IconGridItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final double iconSize;
  final Color color;
  final Function() onTap;

  const IconGridItem({
    super.key,
    required this.imagePath,
    required this.label,
    this.iconSize = 50,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: iconSize,
            height: iconSize,
            color: color, // Applies color filter (works best with monochrome PNGs)
            colorBlendMode: BlendMode.srcIn,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: responsive.size.width * 0.028,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
class IconGridSection extends StatelessWidget {
  const IconGridSection({super.key});
  @override
  Widget build(BuildContext context) {
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    final List<Map<String, dynamic>> items = [
      {'image': 'assets/icons/earas.png', 'label': 'EARAS', 'color': const Color(0xFFfc6076),'page': () => const
     ScreenEarasExt(),
      },
      {'image': 'assets/icons/earas.png', 'label': 'Price', 'color': const Color(0xFF4481eb)},
      {'image': 'assets/icons/labour.png', 'label': 'Labour & Housing', 'color':const Color(0xFF0c3483)},
      {'image': 'assets/icons/iip.png', 'label': 'IIP', 'color': const Color(0xFFFFD194)},
      {'image': 'assets/icons/mccd.png', 'label': 'MCCD', 'color':const Color(0xFFFDC830)},
      {'image': 'assets/icons/costcult.png', 'label': 'Cultivation Cost', 'color':  const Color(0xFF654ea3)},
      {'image': 'assets/icons/soil.png', 'label': 'Evaluation on Soil', 'color': const Color(0xFF00B4DB)},
      {'image': 'assets/icons/localstatistics.png', 'label': 'Statistics', 'color':const Color(0xFF636363)},
      {'image': 'assets/icons/registration.png', 'label': 'Civil Registration', 'color': const Color(0xFFff0844)},
    ];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing:responsive.size.width * 0.08,
        runSpacing: responsive.size.height * 0.03,
        alignment: WrapAlignment.center,
        children: items.map((item) {
          return SizedBox(
            width: responsive.size.width / 4,
            child: IconGridItem(
              imagePath: item['image'],
              label: item['label'],
              iconSize: responsive.size.width * 0.10,
              color: item['color'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => item['page']()),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
