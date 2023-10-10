import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_media_files_state.dart';
import 'package:smp/ui/home_page/home_page.dart';
import 'package:smp/ui/home_page/widgets/appbar_menu/menu_items.dart';
import 'package:smp/ui/home_page/widgets/media_show/show_video_to_user.dart';

///Creating [Player] instance as Global
final player = Player();

///This class is used in the [HomePage], [MenuList], and the [ShowMediaToUser]
///Widgets, is used to setup the media files to play
class SetupMediaFilesToPlay extends Cubit<PickedMediaFile> {
  SetupMediaFilesToPlay()
      : super(InitialPickedMediaFile(
            videoFilePath: "",
            controller: VideoController(player),
            playlist: const Playlist([])));

  ///This [initializeSingleFileMediaPlayer] method is for setting the file for play
  Future<void> initializeSingleFileMediaPlayer(String? path) async {
    try {
      if (path != null) {
        ///setup the [Media] class to play the Media using the File path
        final playable = Media(path);
        await player.open(playable, play: false);

        ///setup the [VideoController] to watch the Media in [HomePage]
        VideoController controller = VideoController(player,
            configuration: const VideoControllerConfiguration());
        emit(MediaPlayingSuccess(
            videoFilePath: path, controller: controller, playlist: null));
      }
    } catch (_) {
      ///If any error occurs then emit the [MediaPlayingError] state
      emit(MediaPlayingError(
          videoFilePath: "",
          controller: VideoController(player),
          playlist: const Playlist([])));
    }
  }

  ///This [initializeMultipleMediaPlayer] method is for setting the Player
  ///to play playlist
  Future<void> initializeMultipleMediaPlayer(Playlist mediaFilesList) async {
    try {
      if (mediaFilesList.medias.isNotEmpty) {
        ///await the [Player] to open the Playlist
        ///and all the medias inside it
        await player.open(mediaFilesList, play: false);

        ///setup the [VideoController] to watch the Media in [HomePage]
        VideoController controller = VideoController(player,
            configuration: const VideoControllerConfiguration());

        emit(MediaPlayingSuccess(
            videoFilePath: "",
            controller: controller,
            playlist: mediaFilesList));
      }
    } catch (_) {
      ///If any error occurs then emit the [MediaPlayingError] state
      emit(MediaPlayingError(
          videoFilePath: "",
          controller: VideoController(player),
          playlist: const Playlist([])));
    }
  }
}
