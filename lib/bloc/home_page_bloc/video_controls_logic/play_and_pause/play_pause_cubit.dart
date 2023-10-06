import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_cubit.dart';
import 'package:smp/bloc/home_page_bloc/video_controls_logic/play_and_pause/play_pause_state.dart';

class UpdateVideoPlayPause extends Cubit<VideoPlayPause>{
  ///Initially passing 'false', means the Video is Playing when it selected
  UpdateVideoPlayPause() : super(VideoPlayPause(isPlaying: true));

  Future<void> playVideo() async{
    await player.play();
    emit(VideoPlayPause(isPlaying: state.isPlaying = true));
  }

  Future<void> pauseVideo() async{
    await player.pause();
    emit(VideoPlayPause(isPlaying: state.isPlaying = false));
  }
}