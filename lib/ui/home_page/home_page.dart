import 'package:flutter/material.dart';
import 'package:smp/ui/home_page/widgets/appbar_menu/appbar_menu_row.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width,
        leading: Builder(builder: (context)=> const HomePageAppBarMenu()),
      ),
    );
  }
}
