import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_media_files_cubit.dart';

part 'play_pause_state.dart';

class UpdateMediaPlayPause extends Cubit<MediaPlayPause>{
  ///Initially passing 'player.state.playing', means the Video is Playing or
  ///not is return by the 'Player'
  UpdateMediaPlayPause() : super(MediaPlayPause(isPlaying: player.state.playing));

  Future<void> playMedia() async{
    emit(const MediaPlaying(isPlaying: true));
    await player.play();
  }

  Future<void> pauseMedia() async{
    emit(const MediaPaused(isPlaying: false));
    await player.pause();
  }
}