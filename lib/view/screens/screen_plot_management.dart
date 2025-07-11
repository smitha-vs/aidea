// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../controller/plot_details.dart';
//
//
// class PlotManagementView extends StatelessWidget {
//   final PlotControllers _plotController = Get.put(PlotControllers());
//
//   PlotManagementView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Field Survey Management'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width * 0.05,
//           vertical: 16,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _buildAddKeyPlotSection(context),
//             const SizedBox(height: 20),
//             _buildKeyPlotsList(context),
//             const SizedBox(height: 20),
//             _buildSidePlotsSection(context),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildAddKeyPlotSection(BuildContext context) {
//     final surveyNumberController = TextEditingController();
//     final notesController = TextEditingController();
//
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Add Key Plot',
//               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: surveyNumberController,
//               decoration: InputDecoration(
//                 labelText: 'Survey Number',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 prefixIcon: const Icon(Icons.numbers),
//               ),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: notesController,
//               decoration: InputDecoration(
//                 labelText: 'Notes (Optional)',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 prefixIcon: const Icon(Icons.note),
//               ),
//               maxLines: 2,
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 if (surveyNumberController.text.isNotEmpty) {
//                   _plotController.addKeyPlot(
//                     surveyNumberController.text,
//                     notesController.text.isEmpty ? null : notesController.text,
//                   );
//                   surveyNumberController.clear();
//                   notesController.clear();
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text('Add Key Plot'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildKeyPlotsList(BuildContext context) {
//     return Obx(() => Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Key Plots',
//           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 8),
//         if (_plotController.plots.isEmpty)
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Text(
//               'No key plots added yet',
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//         if (_plotController.plots.isNotEmpty)
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.25,
//             child: ListView.builder(
//               itemCount: _plotController.plots.length,
//               itemBuilder: (context, index) {
//                 final plot = _plotController.plots[index];
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 8),
//                   child: Slidable(
//                     endActionPane: ActionPane(
//                       motion: const ScrollMotion(),
//                       children: [
//                         SlidableAction(
//                           onPressed: (_) => _plotController.deletePlot(plot),
//                           backgroundColor: Colors.red,
//                           foregroundColor: Colors.white,
//                           icon: Icons.delete,
//                           label: 'Delete',
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ],
//                     ),
//                     child: Card(
//                       elevation: 2,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       color: _plotController.selectedPlot.value == plot
//                           ? Theme.of(context).colorScheme.primaryContainer
//                           : null,
//                       child: ListTile(
//                         onTap: () => _plotController.selectPlot(plot),
//                         leading: const Icon(Icons.key, color: Colors.orange),
//                         title: Text(
//                           plot.surveyNumber,
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (plot.notes != null) Text(plot.notes!),
//                             Text(
//                               DateFormat('MMM dd, yyyy - hh:mm a').format(plot.date),
//                               style: const TextStyle(fontSize: 12),
//                             ),
//                           ],
//                         ),
//                         trailing: Text(
//                           '${plot.sidePlots.length} side plots',
//                           style: const TextStyle(fontSize: 12),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//       ],
//     ));
//   }
//
//   Widget _buildSidePlotsSection(BuildContext context) {
//     return Obx(() {
//       if (_plotController.selectedPlot.value == null) {
//         return Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Center(
//               child: Text(
//                 'Select a key plot to manage side plots',
//                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//           ),
//         );
//       }
//
//       final selectedPlot = _plotController.selectedPlot.value!;
//       return Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Side Plots for ${selectedPlot.surveyNumber}',
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Chip(
//                     label: Text('${selectedPlot.sidePlots.length} plots'),
//                     backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: TextEditingController(
//                           text: _plotController.newSidePlotNumber.value),
//                       onChanged: (value) =>
//                       _plotController.newSidePlotNumber.value = value,
//                       decoration: InputDecoration(
//                         labelText: 'Add Side Plot Number',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         prefixIcon: const Icon(Icons.add),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   IconButton(
//                     onPressed: () {
//                       if (_plotController.newSidePlotNumber.value.isNotEmpty) {
//                         _plotController.addSidePlot(
//                             _plotController.newSidePlotNumber.value);
//                       }
//                     },
//                     icon: const Icon(Icons.add_circle),
//                     color: Theme.of(context).colorScheme.primary,
//                     iconSize: 40,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               if (selectedPlot.sidePlots.isEmpty)
//                 Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Text(
//                     'No side plots added yet',
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: Colors.grey,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               if (selectedPlot.sidePlots.isNotEmpty)
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.2,
//                   child: ListView.builder(
//                     itemCount: selectedPlot.sidePlots.length,
//                     itemBuilder: (context, index) {
//                       return _buildSidePlotItem(context, index, selectedPlot);
//                     },
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   Widget _buildSidePlotItem(BuildContext context, int index, Plot selectedPlot) {
//     final controller = TextEditingController(text: selectedPlot.sidePlots[index]);
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Slidable(
//         endActionPane: ActionPane(
//           motion: const ScrollMotion(),
//           children: [
//             SlidableAction(
//               onPressed: (_) => _plotController.removeSidePlot(index),
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//               icon: Icons.delete,
//               label: 'Delete',
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ],
//         ),
//         child: Card(
//           elevation: 2,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: ListTile(
//             leading: const Icon(Icons.fence, color: Colors.green),
//             title: TextField(
//               controller: controller,
//               decoration: const InputDecoration(
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.zero,
//               ),
//               onSubmitted: (newValue) {
//                 _plotController.updateSidePlot(index, newValue);
//               },
//             ),
//             trailing: const Icon(Icons.drag_handle),
//           ),
//         ),
//       ),
//     );
//   }
// }