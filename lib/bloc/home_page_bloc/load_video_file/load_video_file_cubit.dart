import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_state.dart';

late VideoController controller;

class StartVideoFile extends Cubit<LoadVideoFile> {
  StartVideoFile() : super(LoadVideoFile(videoFilePath: ""));

  final player = Player();

  Future<VideoController> loadVideoPlayer(String path) async {
    try {
      emit(LoadVideoFile(videoFilePath: state.videoFilePath = path));
      final playable = Media(state.videoFilePath);
      await player.open(playable);
      controller = VideoController(player);
      return controller;
    } catch (_) {
      return controller = VideoController(player);
    }
  }
}
