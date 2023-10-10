import 'package:smp/bloc/home_page_bloc/load_video_file/load_media_files_cubit.dart';

class MediaProgressStream {
  ///Use this [progressStream] to stream the Media's Current position
  Stream<Duration> progressStream() async* {
    while (true) {
      yield player.state.position;
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }
}
