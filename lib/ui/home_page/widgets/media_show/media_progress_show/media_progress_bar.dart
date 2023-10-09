import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_bloc.dart';
import 'package:smp/bloc/media_progress_bloc/media_progress_bloc.dart';

class MediaProgressBar extends StatelessWidget {
  const MediaProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    ///Showing the Video Progress using BlocBuilder
    ///the [MediaProgressBloc] emits the Duration Stream
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: BlocBuilder<MediaProgressBloc, MediaProgressState>(

          ///return the [ProgressBar] from the audio_video_progress_bar
          ///package to show the progress of the Media to the User
          builder: (context, progress) => ProgressBar(
              progress: progress.duration,
              progressBarColor: Colors.orangeAccent,
              baseBarColor: Colors.white,
              thumbColor: Colors.orange,
              onSeek: (duration) async {
                await player.seek(Duration(seconds: duration.inSeconds));
              },
              total: player.state.duration)),
    );
  }
}
