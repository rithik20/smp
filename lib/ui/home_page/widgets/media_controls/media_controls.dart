import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_media_files_cubit.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/media_progress_bloc/media_progress_bloc.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/play_and_pause/play_pause_cubit.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/seek/media_seek_cubit.dart';

class MediaControls extends StatelessWidget {
  const MediaControls({super.key});

  @override
  Widget build(BuildContext context) {
    //for play or pause the Media
    final playPause = BlocProvider.of<UpdateMediaPlayPause>(context);

    //for seek the Media by 10 seconds
    final seek = BlocProvider.of<SeekToThisPosition>(context);

    //for stopping the progress of media
    final mediaProgress = BlocProvider.of<MediaProgressBloc>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ///Play previous Media
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: IconButton(
              onPressed: () async {
                //play previous Media if possible
                await player.previous();
              },
              tooltip: "Previous",
              icon: const Icon(Icons.skip_previous)),
        ),

        ///Seek backward for 10 seconds
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: IconButton(
              onPressed: () async {
                //seek 10 seconds forward
                await seek.seekBackward();
              },
              tooltip: "Seek 10 Seconds Backward",
              icon: const Icon(CupertinoIcons.gobackward_10)),
        ),

        ///Play/Pause Button
        Card(
          child: IconButton(
              onPressed: () async {
                ///Get the state of Player and call the Appropriate Methods
                ///in the [UpdateMediaPlayPause] Cubit class
                ///
                /// if the [player] is playing then pause the media
                /// else play the Media
                if (player.state.playing) {
                  //pause the Media
                  await playPause.pauseMedia();
                } else {
                  //play the Media
                  await playPause.playMedia();
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
                //seek 10 seconds forward
                await seek.seekForward();
              },
              tooltip: "Seek 10 Seconds Forward",
              icon: const Icon(CupertinoIcons.goforward_10)),
        ),

        ///Play next Media
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: IconButton(
              onPressed: () async {
                //play next Media if possible
                await player.next();
              },
              tooltip: "Next",
              icon: const Icon(Icons.skip_next)),
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: IconButton(
              onPressed: () async {
                //stop the media and it's progress
                mediaProgress.add(StopProgress());
              },
              tooltip: "Stop Playback",
              icon: const Icon(CupertinoIcons.stop_fill)),
        ),
      ],
    );
  }
}
