import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/video_screen_fit_bloc/video_screen_fit_bloc.dart';

class ScreenFitControl extends StatelessWidget {
  const ScreenFitControl({super.key});

  @override
  Widget build(BuildContext context) {

    final screenFit = BlocProvider.of<ChangeVideoScreenFit>(context);

    return IconButton(
        onPressed: (){
          //change the Screen Size using the [changeScreenSize] method
          screenFit.changeScreenSize();
        },
        tooltip: "Change Screen Fit",
        icon: const Icon(Icons.fit_screen_rounded));
  }
}
