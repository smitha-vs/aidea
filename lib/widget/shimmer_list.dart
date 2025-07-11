import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});
  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        height: 200,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.builder(
            itemCount: 5, // Adjust the count based on your needs
            itemBuilder: (context, index) {
              return ListTile(
                title: Container(
                  height: 20,
                  width: 200,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
      );
  }
}