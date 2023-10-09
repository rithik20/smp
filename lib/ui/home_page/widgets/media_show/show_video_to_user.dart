import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_bloc.dart';
import 'package:smp/bloc/home_page_bloc/video_controls_logic/media_volume_bloc/media_volume_bloc.dart';
import 'package:smp/bloc/home_page_bloc/video_controls_logic/seek/video_seek_cubit.dart';
import 'package:smp/bloc/video_full_screen_bloc/video_fullscreen_cubit.dart';
import 'package:smp/bloc/video_screen_fit_bloc/video_screen_fit_bloc.dart';
import 'package:smp/bloc/video_screen_fit_bloc/video_screen_fit_state.dart';

class ShowMediaToUser extends StatelessWidget {
  const ShowMediaToUser({super.key});

  @override
  Widget build(BuildContext context) {
    //for managing the seek of media
    final seek = BlocProvider.of<SeekToThisPosition>(context);

    //For managing the volume of media
    final volume = BlocProvider.of<UpdateMediaVolume>(context);

    final fullScreen = BlocProvider.of<VideoFullscreenCubit>(context);


    return GestureDetector(
      onDoubleTap: () async {
        ///check the [isFullscreen] variable in the State class of
        ///VideoFullscreenCubit is true or not
        ///and call the appropriate methods for FullScreen State
        if (fullScreen.state.isFullscreen) {
          await fullScreen.exitFullScreen();
        } else {
          await fullScreen.goToFullScreen();
        }
      },
      child: BlocBuilder<ChangeVideoScreenFit, VideoScreenFit>(
          builder: (context, screen) {
        return KeyboardListener(
          ///Different Keyboard Events
          onKeyEvent: (event) async {
            if (event.physicalKey == PhysicalKeyboardKey.arrowRight) {
              ///If the user pressed the RightArrow Key in their Keyboard
              ///Move 10 Seconds Forward
              await seek.seekForward();
            } else if (event.physicalKey == PhysicalKeyboardKey.arrowLeft) {
              ///If the user pressed the RightArrow Key in their Keyboard
              ///Move 10 Seconds Backward
              await seek.seekBackward();
            } else if (event.physicalKey == PhysicalKeyboardKey.space) {
              ///If the user pressed the SpaceBar Key in their Keyboard
              ///Play or Pause The Media
              await player.playOrPause();
            } else if (event.physicalKey == PhysicalKeyboardKey.arrowUp) {
              ///If the user pressed the UpArrow Key in their Keyboard
              ///Increase the Volume by 10
              await volume.increaseVolume();
            } else if (event.physicalKey == PhysicalKeyboardKey.arrowDown) {
              ///If the user pressed the UpArrow Key in their Keyboard
              ///decrease the Volume by 10
              await volume.decreaseVolume();
            }else if(event.physicalKey == PhysicalKeyboardKey.escape){
              await fullScreen.exitFullScreen();
            }
          },
          focusNode: FocusNode(),

          ///Show the Video to User
          child: Video(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,

              ///Change the Screen Fit With User interaction
              ///Using [ChangeVideoScreenFit] Bloc
              fit: screen.fit,
              filterQuality: FilterQuality.high,

              ///Use subtitles if possible
              subtitleViewConfiguration: const SubtitleViewConfiguration(
                  visible: true, textAlign: TextAlign.center),

              ///Changing the Default Controls with NoVideoControls
              controls: NoVideoControls,
              controller: controller),
        );
      }),
    );
  }
}
