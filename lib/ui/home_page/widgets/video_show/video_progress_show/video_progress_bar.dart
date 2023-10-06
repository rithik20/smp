import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_cubit.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_state.dart';
import 'package:smp/providers/video_progress_stream/video_progress_stream.dart';

class VideoProgressBar extends StatelessWidget {
  const VideoProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final videoProgressStream = Provider.of<VideoProgressStreamClass>(context);

    ///Showing the Video Progress using StreamBuilder
    return BlocBuilder<StartVideoFile, LoadVideoFile>(
        builder: (context, state) {
      return Visibility(
        visible: state.videoFilePath.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 40.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: StreamBuilder<Duration?>(
                stream: videoProgressStream.progressStream(),
                builder: (context, data) {
                  if (data.hasData) {
                    return ProgressBar(
                        onSeek: (duration) async {
                          await player
                              .seek(Duration(seconds: duration.inSeconds));
                        },
                        progressBarColor: Colors.orangeAccent,
                        baseBarColor: Colors.white,
                        thumbColor: Colors.orange,
                        progress: data.data!,
                        total: player.state.duration);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ),
      );
    });
  }
}
