import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DownloadFileListAppBar extends StatelessWidget {
  const DownloadFileListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(CupertinoIcons.down_arrow),
        itemBuilder: (context) =>
            [
            ]
    );
  }
}
