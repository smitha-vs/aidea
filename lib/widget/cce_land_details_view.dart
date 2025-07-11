import 'package:aidea/widget/text_field.dart';
import 'package:flutter/material.dart';

import '../resources/constants/screen_responsive.dart';
class LandCCEView extends StatelessWidget {
  const LandCCEView({super.key});
  @override
  Widget build(BuildContext context) {
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Panchayath', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5.0),
          MyTextField(
             txt: '',
            hintText: 'Enter Panchayath',
            obscureText: false,
            width: responsive.screenWidth * 0.8,
            controller: TextEditingController(text: 'Alappuzha'), // Example value
            enabled: false,
          ),
          const SizedBox(height: 20.0),

          const Text('Cluster Number', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5.0),
          MyTextField(
            txt: '',
            hintText: 'Cluster Number',
            obscureText: false,
            width: responsive.screenWidth * 0.8,
            controller: TextEditingController(text: '12'),
            enabled: false,
          ),
          const SizedBox(height: 20.0),

          const Text('Survey No', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5.0),
          MyTextField(
            txt: '',
            hintText: 'Survey No',
            obscureText: false,
            width: responsive.screenWidth * 0.8,
            controller: TextEditingController(text: '105/3A'),
            enabled: false,
          ),
          const SizedBox(height: 20.0),

          const Text('Total Area', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5.0),
          MyTextField(
            txt: '',
            hintText: 'Total Area',
            obscureText: false,
            width: responsive.screenWidth * 0.8,
            controller: TextEditingController(text: '2.5 are'),
            enabled: false,
          ),
        ],
      ),
    );
  }
}
