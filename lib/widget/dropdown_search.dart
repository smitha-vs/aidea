import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItem {
  final int id;
  final String label;
  MenuItem(this.id, this.label);
}

class MenuController extends GetxController {
  final Rx<MenuItem?> selectedMenu = Rx<MenuItem?>(null);
  final TextEditingController searchController = TextEditingController();

  final List<MenuItem> menuItems = [
    MenuItem(1, 'Wheat'),
    MenuItem(2, 'Coconut'),
    MenuItem(3, 'Tapioca'),
    MenuItem(4, 'Ginger'),
    MenuItem(5, 'Sugarcane'),
    MenuItem(6, 'Seasame'),
  ];

  void selectMenu(MenuItem? item) {
    selectedMenu.value = item;
    searchController.text = item?.label ?? '';
  }
}
class DropdownMenuSample extends StatelessWidget {
  final MenuController menuController;

  const DropdownMenuSample({super.key, required this.menuController});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 16.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownMenu<MenuItem>(
          controller: menuController.searchController,
          width: width,
          hintText: "Select Menu",
          requestFocusOnTap: true,
          enableFilter: true,
          label: const Text('Select Menu'),
          menuStyle: MenuStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Colors.lightBlue.shade50),
          ),
          onSelected: (MenuItem? menu) {
            menuController.selectMenu(menu);
          },
          dropdownMenuEntries: menuController.menuItems
              .map<DropdownMenuEntry<MenuItem>>((MenuItem item) {
            return DropdownMenuEntry<MenuItem>(
              value: item,
              label: item.label,
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Obx(() => Text(
          "Selected: ${menuController.selectedMenu.value?.label ?? 'None'}",
          style: const TextStyle(fontSize: 14),
        )),
      ],
    );
  }
}
