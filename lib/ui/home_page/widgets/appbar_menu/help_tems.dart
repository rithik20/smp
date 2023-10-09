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
      onSelected: (value) async {
        if (value == 0) {
          await showAdaptiveDialog(
              context: context,
              builder: (context) => const AlertDialog(
                    title: Center(
                        child: Text(
                      "Checking For Updates",
                      style: TextStyle(fontSize: 20.0),
                    )),
                    content: SingleChildScrollView(
                        child: Center(
                      child: LinearProgressIndicator(),
                    )),
                  ));
        }
      },
    );
  }
}
