import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'video_screen_fit_state.dart';

class ChangeVideoScreenFit extends Cubit<VideoScreenFit> {
  ///initially pass [BoxFit.fitWidth] as the Initial value
  ChangeVideoScreenFit()
      : super(const InitialVideoScreenFit(
            fit: BoxFit.fitWidth,
            screenFitString: "Fit Width",
            isVisible: false));

  int counter = 0;

  void changeScreenSize() {
    counter++;
    List<BoxFit> screenFit = [
      BoxFit.cover,
      BoxFit.contain,
      BoxFit.fill,
      BoxFit.fitHeight,
      BoxFit.fitWidth,
      BoxFit.scaleDown,
    ];

    List<String> screenFitString = [
      "Cover",
      "Best Fit",
      "Fill",
      "Fit Height",
      "Fit Width",
      "Center"
    ];
    if (counter > screenFit.length - 1) {
      counter = 0;
    }
    emit(VideoScreenFit(
        fit: screenFit[counter],
        screenFitString: screenFitString[counter],
        isVisible: true));

    ///This Timer is for a Simple Animation to Show the Screen Fit in the UI
    ///After 1 second the [isVisible] will become false
    Timer(const Duration(seconds: 1), () {
      emit(VideoScreenFit(
          fit: state.fit,
          screenFitString: state.screenFitString,
          isVisible: false));
    });
  }
}
