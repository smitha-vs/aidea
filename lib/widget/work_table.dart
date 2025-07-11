import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // allows full-height bottom sheet
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text("Filters and Sorting", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      FilterChip(label: Text("Veg"), selected: false, onSelected: (_) {}),
                      SizedBox(width: 8),
                      FilterChip(label: Text("Non-Veg"), selected: false, onSelected: (_) {}),
                      SizedBox(width: 8),
                      FilterChip(label: Text("Egg"), selected: false, onSelected: (_) {}),
                    ],
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Apply Filters"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Zomato Filter UI Demo")),
      body: Center(
        child: ElevatedButton(
          child: Text("Open Filters"),
          onPressed: () => _showFilterSheet(context),
        ),
      ),
    );
  }
}
