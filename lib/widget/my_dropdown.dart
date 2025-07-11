import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final RxString selectedValue;
  final double? width;
  final bool enabled;

  const MyDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.selectedValue,
    this.width,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
      width: width,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: selectedValue.value.isNotEmpty &&
                items.contains(selectedValue.value)
                ? selectedValue.value
                : null,
            hint: Text('Select $label'),
            items: items
                .map((item) =>
                DropdownMenuItem<String>(value: item, child: Text(item)))
                .toList(),
            onChanged: enabled
                ? (val) {
              if (val != null) {
                selectedValue.value = val;
              }
            }
                : null,
          ),
        ),
      ),
    ));
  }
}
