import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_media_files_cubit.dart';
import 'package:smp/data/media_playing_state_stream/media_playing_state_stream.dart';
import 'package:smp/dependency_injection/get_it_dependencies.dart';

part 'media_play_pause_stream_event.dart';

part 'media_play_pause_stream_state.dart';

///This [MediaPlayPauseStreamBloc] will stream the state of [player.state.playing]
///and emit the states based on the stream value
class MediaPlayPauseStreamBloc
    extends Bloc<MediaPlayPauseStreamEvent, MediaPlayPauseStreamState> {

  ///initially passing "false" as the state means media not playing
  ///Here using the [MediaPlayingStateStream] as the Data Provider
  ///and the [MediaPlayingStateStream.mediaPlayingStream] as the Stream
  ///
  MediaPlayPauseStreamBloc()
      : super(const MediaPlayPauseStreamInitial(isPlaying: false)) {
    on<StartMediaEvent>((event, emit) async{

      ///Emit the states based on the [mediaPlayingStream] in the
      ///MediaPlayingStateStream Data Provider
      await emit.forEach(getIt<MediaPlayingStateStream>().mediaPlayingStream(),
          onData: (data) {
        if (data == true) {
          return const MediaPlaying(isPlaying: true);
        } else {
          return const MediaPaused(isPlaying: false);
        }
      });
    });
  }
}
