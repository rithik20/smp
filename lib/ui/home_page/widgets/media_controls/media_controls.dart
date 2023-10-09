import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_bloc.dart';
import 'package:smp/bloc/home_page_bloc/video_controls_logic/play_and_pause/play_pause_cubit.dart';
import 'package:smp/bloc/home_page_bloc/video_controls_logic/seek/video_seek_cubit.dart';

class VideoControls extends StatelessWidget {
  const VideoControls({super.key});

  @override
  Widget build(BuildContext context) {
    //for play or pause the Media
    final playPause = BlocProvider.of<UpdateMediaPlayPause>(context);

    //for seek the Media by 10 seconds
    final seek = BlocProvider.of<SeekToThisPosition>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ///Seek backward for 10 seconds
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: IconButton(
              onPressed: () async {
                seek.seekBackward();
                await player
                    .seek(Duration(seconds: seek.state.currentDuration));
              },
              tooltip: "Seek 10 Seconds Backward",
              icon: const Icon(CupertinoIcons.gobackward_10)),
        ),

        ///Play/Pause Button
        Card(
          child: IconButton(
              onPressed: () async {
                ///Get the state of Player and call the Appropriate Methods
                ///in the [UpdateVideoPlayPause] Cubit class
                ///
                /// if the [player] is playing then pause the video
                /// else play the video
                if (player.state.playing) {
                  await playPause.pauseVideo();
                } else {
                  await playPause.playVideo();
                }
              },
              tooltip: "Play/Pause",

              ///Rebuild the Icon based on the [MediaPlayPause] class's
              ///state
              icon: BlocBuilder<UpdateMediaPlayPause, MediaPlayPause>(
                  builder: (context, playing) {
                ///Rebuild the Icons based on the state
                if (playing.isPlaying) {
                  return const Icon(
                    Icons.pause,
                    size: 30.0,
                  );
                } else {
                  return const Icon(
                    CupertinoIcons.play_arrow_solid,
                    size: 30.0,
                  );
                }
              })),
        ),

        ///Seek forward for 10 seconds
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: IconButton(
              onPressed: () async {
                seek.seekForward();
                await player
                    .seek(Duration(seconds: seek.state.currentDuration));
              },
              tooltip: "Seek 10 Seconds Forward",
              icon: const Icon(CupertinoIcons.goforward_10)),
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: IconButton(
              onPressed: () async {
                await player.stop();
              },
              tooltip: "Stop Playback",
              icon: const Icon(CupertinoIcons.stop_fill)),
        ),
      ],
    );
  }
}
