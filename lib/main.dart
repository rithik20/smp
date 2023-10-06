import 'package:flutter/material.dart';
import 'package:smp/ui/home_page/home_page.dart';

void main(){

  runApp(const MediaPlayer());
}

class MediaPlayer extends StatelessWidget {
  const MediaPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
