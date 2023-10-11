import 'package:bloc/bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:flutter/material.dart';
import 'package:smp/ui/home_page/home_page.dart';
import 'package:smp/ui/home_page/widgets/media_controls/media_controls.dart';

part 'app_bar_media_information_state.dart';

///This [AppBarMediaInformationCubit] and the [AppBarMediaInformationState]
///class is for Storing the Media Files path, to show in the [AppBar] of
///[HomePage] Widget
///
class AppBarMediaInformationCubit extends Cubit<AppBarMediaInformationState> {
  AppBarMediaInformationCubit()
      : super(const AppBarMediaInformationInitial(
            singleMedia: '',
            playlist: Playlist([], index: 0),
            playlistIndex: 0));

  ///call this [singleMedia] method to add only the Single media information
  ///in the [singleMedia] property of the [AppBarMediaInformationState] state
  ///class
  void singleMedia(String? path) {
    emit(SingleMediaAppBar(
        singleMedia: path,
        playlist: const Playlist([], index: 0),
        playlistIndex: 0));
  }

  ///call this [playlistMedia] method to add only the [Playlist] information
  ///in the [playlist] property of the [AppBarMediaInformationState] state
  ///class
  void playlistMedia(Playlist playlistMedias) {
    emit(PlaylistMediaAppBar(
        singleMedia: "", playlist: playlistMedias, playlistIndex: 0));
  }

  ///This [nextIndex] method will increase the [playlistIndex]
  ///by "1", this method is used in the [MediaControls] Widget
  ///This method is only work for when dealing with [Playlist]
  void nextIndex() {
    if (state.playlistIndex < state.playlist!.medias.length - 1) {
      int index = state.playlistIndex + 1;
      emit(PlaylistMediaAppBar(
          singleMedia: "", playlist: state.playlist, playlistIndex: index));
    }
  }

  ///This [nextIndex] method will decrease the [playlistIndex]
  ///by "1", this method is used in the [MediaControls] Widget
  ///This method is only work for when dealing with [Playlist]
  void previousIndex() {
    if (state.playlistIndex != 0) {
      int index = state.playlistIndex - 1;
      emit(PlaylistMediaAppBar(
          singleMedia: "", playlist: state.playlist, playlistIndex: index));
    }
  }
}
