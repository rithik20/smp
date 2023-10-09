import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_bloc.dart';
import 'package:smp/bloc/home_page_bloc/video_controls_logic/media_volume_bloc/media_volume_state.dart';

class UpdateMediaVolume extends Cubit<MediaVolumeState> {
  UpdateMediaVolume()
      : super(MediaVolumeState(
            mediaVolume: player.state.volume, isVisible: false));

  Future<void> increaseVolume() async {

    final currentVolume = player.state.volume + 10.0;

    emit(MediaVolumeState(
        mediaVolume: state.mediaVolume = currentVolume,
        isVisible: state.isVisible = true));

    await player.setVolume(currentVolume);

    ///This Timer is for a Simple Animation to Show the Volume in the UI
    ///After 1 second the [isVisible] will become false
    Timer(const Duration(seconds: 1), () {
      emit(MediaVolumeState(
          mediaVolume: state.mediaVolume, isVisible: state.isVisible = false));
    });
  }

  Future<void> decreaseVolume() async {
    final currentVolume = player.state.volume - 10.0;

    emit(MediaVolumeState(
        mediaVolume: state.mediaVolume = currentVolume,
        isVisible: state.isVisible = true));

    await player.setVolume(currentVolume);

    ///This Timer is for a Simple Animation to Show the Volume in the UI
    ///After 1 second the [isVisible] will become false
    Timer(const Duration(seconds: 1), () {
      emit(MediaVolumeState(
          mediaVolume: state.mediaVolume, isVisible: state.isVisible = false));
    });
  }
}
