import 'package:flutter/material.dart';
import 'package:smp/ui/home_page/widgets/appbar_menu/help_items.dart';
import 'package:smp/ui/home_page/widgets/appbar_menu/menu_items.dart';
import 'package:smp/ui/home_page/widgets/appbar_menu/subtitle_menu.dart';

class HomePageAppBarMenu extends StatelessWidget {
  const HomePageAppBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      ///calling all needed Row Items
      children: const [
        MenuList(),
        SubtitleTrackMenu(),
        HelpList(),
      ],
    );
  }
}
