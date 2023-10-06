import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_cubit.dart';
import 'package:smp/ui/home_page/widgets/video_controls/video_controls.dart';
import 'package:smp/ui/home_page/widgets/video_show/video_progress_show/video_progress_bar.dart';

class ShowVideoToUser extends StatelessWidget {
  const ShowVideoToUser({super.key});

  @override
  Widget build(BuildContext context) {
    //For opening Files From Device using Menu List
    final loadFile = BlocProvider.of<StartVideoFile>(context);

    return GestureDetector(
      onDoubleTap: () async {
        ///when tap increase the [fullScreenCount] in the [StartVideoFile]
        ///Cubit class
        loadFile.fullScreenCount++;
        if (loadFile.fullScreenCount % 2 == 0) {
          //change the value of [fullScreen] to true
          fullScreen = true;
          await defaultEnterNativeFullscreen();
        } else {
          //change the value of [fullScreen] to false
          fullScreen = false;
          await defaultExitNativeFullscreen();
        }
      },
      child: Stack(
        children: [
          Video(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              fit: BoxFit.contain,

              ///Changing the Default Controls with NoVideoControls
              controls: NoVideoControls,
              controller: controller),
          const VideoControls(),
          SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: const VideoProgressBar()),
        ],
      ),
    );
  }
}
