import 'package:flutter/material.dart';

class PlotInfoCard extends StatelessWidget {
  final List<Map<String, dynamic>> dataList;
  const PlotInfoCard({super.key, required this.dataList});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: dataList.map((data) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          elevation: 2,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Local Body Name heading
                Text(
                  "Local Body Name: ${data['Panchayath Name'] ?? 'N/A'}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Table(
                  border: TableBorder.all(color: Colors.black),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(1.5),
                    3: FlexColumnWidth(1.5),
                    4: FlexColumnWidth(1.5),
                  },
                  children: [
                    _buildTableHeaderRow(),
                    _buildTableDataRow(data),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAreaText("Area of Dry Plot", data["Dry Area"]),
                    _buildAreaText("Area of Wet Plot", data["Wet Area"]),
                  ],
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
  TableRow _buildTableHeaderRow() {
    return  TableRow(
      decoration: BoxDecoration(color: Colors.black54),
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Village", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Block", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Wet", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Dry", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Total", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
        ),
      ],
    );
  }

  TableRow _buildTableDataRow(Map<String, dynamic> data) {
    return TableRow(
      children: [
        _tableCell(data["Village"]),
        _tableCell(data["Block"]),
        _tableCell(data["Wet Plots"]),
        _tableCell(data["Dry Plots"]),
        _tableCell(data["Total Plots"]),
      ],
    );
  }

  Widget _tableCell(dynamic value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(value?.toString() ?? "", style: const TextStyle(fontSize: 12)),
    );
  }
  Widget _buildAreaText(String label, dynamic value) {
    return Text(
      "$label: ${value?.toString() ?? '0'}",
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }
}
