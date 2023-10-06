import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_state.dart';
import 'package:smp/ui/home_page/home_page.dart';

///Creating [Player] instance as Global
final player = Player();

VideoController controller = VideoController(player);

///For controlling the AppBar Hide. This variable is used the [HomePage] Widget's
///[AppBar]
bool fullScreen = false;

class StartVideoFile extends Cubit<LoadVideoFile> {
  StartVideoFile() : super(LoadVideoFile(videoFilePath: ""));

  int fullScreenCount = 1;

  ///This [loadVideoPlayer] method is for setting the file for play
  Future<void> loadVideoPlayer(String path) async {
    try {
      emit(LoadVideoFile(videoFilePath: state.videoFilePath = path));
      final playable = Media(state.videoFilePath);
      await player.open(playable);
      controller = VideoController(player);

      ///Then Play the Video
      await player.play();
    } catch (_) {
      throw _.toString();
    }
  }
}
