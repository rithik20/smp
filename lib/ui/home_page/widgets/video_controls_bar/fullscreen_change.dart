import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:smp/bloc/appBar_media_information/app_bar_media_information_cubit.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/video_full_screen_bloc/video_fullscreen_cubit.dart';

class FullscreenSwitchMode extends StatelessWidget {
  const FullscreenSwitchMode({super.key});

  @override
  Widget build(BuildContext context) {
    //for working with Fullscreen in and out
    final fullscreen = BlocProvider.of<VideoFullscreenCubit>(context);

    //for checking any media file open or not?
    final mediaInfo = BlocProvider.of<AppBarMediaInformationCubit>(context);

    return BlocBuilder<VideoFullscreenCubit, VideoFullscreenState>(
      builder: (context, state) {
        return IconButton(
            tooltip:
                state.isFullscreen ? "Exit FullScreen" : "Go To Fullscreen",
            onPressed: () async {
              ///Only work the Enter Fullscreen and Exit Fullscreen when
              ///opened media files
              if (mediaInfo.state.singleMedia != "" ||
                  mediaInfo.state.playlist != const Playlist([])) {
                if (state.isFullscreen) {
                  Navigator.pop(context);
                  await Future.delayed(const Duration(microseconds: 100));
                  await fullscreen.exitFullScreen();
                } else {
                  await fullscreen.goToFullScreen();
                }
              }
            },
            icon: state.isFullscreen
                ? const Icon(Icons.fullscreen_exit)
                : const Icon(Icons.fullscreen));
      },
    );
  }
}
