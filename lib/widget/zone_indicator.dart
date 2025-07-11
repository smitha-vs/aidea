import 'package:flutter/material.dart';

class IndicatorTile extends StatelessWidget {
  final String title;
  final String value;
  const IndicatorTile({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.blue, fontSize: 14)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
