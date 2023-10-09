import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_bloc.dart';
import 'package:smp/bloc/home_page_bloc/video_controls_logic/seek/video_seek_state.dart';

class SeekToThisPosition extends Cubit<VideoCurrentPosition> {
  ///Initially passing the [Duration] as 0 'milliseconds'
  SeekToThisPosition() : super(VideoCurrentPosition(currentDuration: 0));

  Future<void> seekForward() async {
    int currentPosition = player.state.position.inSeconds;
    emit(VideoCurrentPosition(
        currentDuration: state.currentDuration = currentPosition + 10));
    await player.seek(Duration(seconds: state.currentDuration));
  }

  Future<void> seekBackward() async {
    int currentPosition = player.state.position.inSeconds;
    emit(VideoCurrentPosition(
        currentDuration: state.currentDuration = currentPosition - 10));

    await player.seek(Duration(seconds: state.currentDuration));
  }
}
