import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_media_files_cubit.dart';

part 'media_volume_state.dart';

class UpdateMediaVolume extends Cubit<MediaVolumeState> {
  UpdateMediaVolume()
      : super(InitialMediaVolumeState(mediaVolume: player.state.volume, isVisible: false));

  Future<void> increaseVolume() async {
    ///Stop increasing the Volume when reached 200!
    if (player.state.volume != 200) {
      ///Increase the Volume by 10
      final currentVolume = state.mediaVolume + 10.0;

      ///Emit the Success State
      emit(MediaVolumeIncreased(
          mediaVolume: currentVolume,
          isVisible:  true));

      ///await the [Player] to increase the volume using the [currentVolume]
      await player.setVolume(currentVolume);

      ///This Timer is for a Simple Animation to Show the Volume in the UI
      ///After 1 second the [isVisible] will become false
      Timer(const Duration(seconds: 1), () {
        emit(MediaVolumeIncreased(
            mediaVolume: state.mediaVolume,
            isVisible: false));
      });
    }
  }

  Future<void> decreaseVolume() async {
    ///Stop decreasing the Volume when reached 0!
    if (player.state.volume != 0) {
      ///decrease the Volume by 10
      final currentVolume = state.mediaVolume - 10.0;

      ///Emit the Success State
      emit(MediaVolumeDecreased(
          mediaVolume:  currentVolume,
          isVisible: true));

      ///await the [Player] to decrease the volume using the [currentVolume]
      await player.setVolume(currentVolume);

      ///This Timer is for a Simple Animation to Show the Volume in the UI
      ///After 1 second the [isVisible] will become false
      Timer(const Duration(seconds: 1), () {
        emit(MediaVolumeDecreased(
            mediaVolume: state.mediaVolume,
            isVisible: false));
      });
    }
  }
}
