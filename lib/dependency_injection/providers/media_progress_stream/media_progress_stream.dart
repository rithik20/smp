import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_bloc.dart';

class MediaProgressStream{

  ///Use this [progressStream] to stream the Video's Current position
  Stream<Duration> progressStream() async*{

    while(true) {
      yield player.state.position;
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }
}