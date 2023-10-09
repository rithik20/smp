import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_state.dart';
import 'package:smp/ui/home_page/widgets/media_show/show_video_to_user.dart';

///Creating [Player] instance as Global
final player = Player();

///Use this [controller] to play the Video, this controller is called in the
///[ShowMediaToUser] Widget's [Video] Widget.
VideoController controller = VideoController(player);

class SetupMediaFileToPlay extends Cubit<PickedMediaFile> {
  SetupMediaFileToPlay() : super(PickedMediaFile(videoFilePath: ""));

  ///This [initializeMediaPlayer] method is for setting the file for play
  Future<void> initializeMediaPlayer(String path) async {
    try {
      emit(PickedMediaFile(videoFilePath: state.videoFilePath = path));
      final playable = Media(state.videoFilePath);
      await player.open(playable);
      controller = VideoController(player);
    } catch (_) {
      throw _.toString();
    }
  }
}
