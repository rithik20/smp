part of 'app_bar_media_information_cubit.dart';

@immutable
abstract class AppBarMediaInformationState {
  final String? singleMedia;
  final Playlist? playlist;
  final int playlistIndex;

  const AppBarMediaInformationState(
      {required this.singleMedia,
      required this.playlist,
      required this.playlistIndex});
}

class AppBarMediaInformationInitial extends AppBarMediaInformationState {
  const AppBarMediaInformationInitial(
      {required super.singleMedia,
      required super.playlist,
      required super.playlistIndex});
}

class SingleMediaAppBar extends AppBarMediaInformationState {
  const SingleMediaAppBar(
      {required super.singleMedia,
        required super.playlist,
        required super.playlistIndex});
}

class PlaylistMediaAppBar extends AppBarMediaInformationState {
  const PlaylistMediaAppBar(
      {required super.singleMedia,
        required super.playlist,
        required super.playlistIndex});
}
