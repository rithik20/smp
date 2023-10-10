import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_media_files_cubit.dart';
import 'package:smp/dependency_injection/get_it_dependencies.dart';
import 'package:smp/dependency_injection/providers/media_progress_stream/media_progress_stream.dart';

part 'media_progress_event.dart';

part 'media_progress_state.dart';

class MediaProgressBloc extends Bloc<MediaProgressEvent, MediaProgressState> {
  MediaProgressBloc()
      : super(const MediaProgressInitial(duration: Duration(seconds: 0))) {
    ///when using the [StartProgress] event get the Duration from the Stream
    on<StartProgress>((event, emit) async {
      await emit.forEach(
          //pass the [progressStream()] from the MediaProgressStream
          getIt<MediaProgressStream>().progressStream(),
          onData: (Duration data) => MediaProgressStarted(duration: data),
          onError: (object, stack) =>
              const MediaProgressError(duration: Duration(seconds: 0)));
    });

    on<StopProgress>((event, emit) async {
      emit(const MediaProgressStopped(duration: Duration(seconds: 0)));
      await player.stop();
    });
  }
}
