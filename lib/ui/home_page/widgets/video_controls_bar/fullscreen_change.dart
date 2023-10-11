import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/video_full_screen_bloc/video_fullscreen_cubit.dart';

class FullscreenSwitchMode extends StatelessWidget {
  const FullscreenSwitchMode({super.key});

  @override
  Widget build(BuildContext context) {
    final fullscreen = BlocProvider.of<VideoFullscreenCubit>(context);

    return BlocBuilder<VideoFullscreenCubit, VideoFullscreenState>(
      builder: (context, state) {
        return IconButton(
          tooltip: state.isFullscreen ? "Exit FullScreen" :
            "Go To Fullscreen",
            onPressed: () async {
              if (state.isFullscreen) {
                Navigator.pop(context);
                await Future.delayed(const Duration(microseconds: 100));
                await fullscreen.exitFullScreen();
              } else {
                await fullscreen.goToFullScreen();
              }
            },
            icon: state.isFullscreen
                ? const Icon(Icons.fullscreen_exit)
                : const Icon(Icons.fullscreen));
      },
    );
  }
}
