import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Text("Menu"),
      itemBuilder: (context) => [
        //Open File
        const PopupMenuItem(
            value: 0,
            child: Row(
              children: [Icon(Icons.file_open_outlined), Text("Open File")],
            )),

        //Quit
        const PopupMenuItem(
            value: 1,
            child: Row(
              children: [Icon(Icons.exit_to_app_outlined), Text("Quit")],
            )),
      ],
      onSelected: (value) {},
    );
  }
}
