import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpList extends StatelessWidget {
  const HelpList({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Text("Help"),
      itemBuilder: (context) => [
        const PopupMenuItem(
            value: 0,
            child: Row(
              children: [Text("Check For Updates")],
            )),

        //Quit
        const PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                Icon(CupertinoIcons.exclamationmark_circle),
                Text("About")
              ],
            )),
      ],
      onSelected: (value) {},
    );
  }
}
