import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';

part 'video_fullscreen_state.dart';

class VideoFullscreenCubit extends Cubit<VideoFullscreenState> {
  VideoFullscreenCubit()
      : super(const VideoFullscreenInitial(isFullscreen: false));

  Future<void> goToFullScreen() async {
    emit(const FullscreenMode(isFullscreen: true));

    ///call the [defaultEnterNativeFullscreen] from the media_kit_video package
    ///to Enter the NativeFullScreen
    await defaultEnterNativeFullscreen();
  }

  Future<void> exitFullScreen() async {
    emit(const FullscreenExited(isFullscreen: false));

    ///call the [defaultExitNativeFullscreen] from the media_kit_video package
    ///to Exit from the NativeFullScreen
    await defaultExitNativeFullscreen();
  }
}
