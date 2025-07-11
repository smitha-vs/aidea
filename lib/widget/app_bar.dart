import 'package:flutter/material.dart';

import '../resources/constants/screen_responsive.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final VoidCallback onMenuTap;
  final bool hideLeading; // Add this parameter
  const CustomAppBar({
    super.key,
    required this.title,
    required this.onMenuTap,
    this.hideLeading = false, // Default is false
  });
  @override
  Widget build(BuildContext context) {
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      toolbarHeight: 70,
      elevation: 0,
      backgroundColor: Colors.grey[700],
      title: title, // <-- Add this line to show the title
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
      ),
      leading: hideLeading
          ? null
          : Builder(
        builder: (context) {
          double iconSize = responsive.size.width * 0.07;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: iconSize.clamp(24.0, 40.0),
              ),
              onPressed: onMenuTap,
            ),
          );
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.account_circle, color: Colors.grey[700]),
            ),
          ),
        ),
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(70);
}
