import 'package:smp/bloc/home_page_bloc/load_video_file/load_media_files_cubit.dart';

class MediaPlayingStateStream {
  Stream<bool> mediaPlayingStream() async* {
    while (true) {
      yield player.state.playing;

      await Future.delayed(const Duration(milliseconds: 1));
    }
  }
}
