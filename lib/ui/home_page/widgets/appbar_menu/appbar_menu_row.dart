import 'package:flutter/material.dart';

class HomePageAppBarMenu extends StatelessWidget {
  const HomePageAppBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: const [
        Text("Menu"),
        Text("Menu"),
        Text("Menu"),
        Text("Menu"),
      ],
    );
  }
}
