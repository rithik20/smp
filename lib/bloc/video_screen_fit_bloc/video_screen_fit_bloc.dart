import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/video_screen_fit_bloc/video_screen_fit_state.dart';

class ChangeVideoScreenFit extends Cubit<VideoScreenFit> {
  ///initially pass [BoxFit.fitWidth] as the Initial value
  ChangeVideoScreenFit() : super(VideoScreenFit(fit: BoxFit.fitWidth));

  int counter = 0;

  void changeScreenSize() {
    counter++;
    List<BoxFit> screenFit = [
      BoxFit.cover,
      BoxFit.contain,
      BoxFit.fill,
      BoxFit.fitHeight,
      BoxFit.scaleDown,
      BoxFit.fitWidth
    ];
    if(counter > screenFit.length - 1){
      counter = 0;
    }
    emit(VideoScreenFit(fit: state.fit = screenFit[counter]));
  }
}
