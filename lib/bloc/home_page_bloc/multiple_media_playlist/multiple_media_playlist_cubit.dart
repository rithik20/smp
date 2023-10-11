import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:media_kit/media_kit.dart';
import 'package:flutter/material.dart';

part 'multiple_media_playlist_state.dart';

class MultipleMediaPlaylistCubit extends Cubit<MultipleMediaPlaylistState> {
  MultipleMediaPlaylistCubit()
      : super(const MultipleMediaPlaylistInitial(playlist: Playlist([], index: 0)));

  void addAllMediasToPlaylist(List<PlatformFile>? list){
    try {
      if (list!.isNotEmpty) {
        List<Media> playlist = [];

        for (int i = 0; i < list.length; i ++) {
          playlist.add(Media(list[i].path!));
        }
        emit(MultipleMediaPlaylistCreated(playlist: Playlist(playlist, index: 0)));
      }
    }catch(_){
      emit(const MultipleMediaPlaylistError(playlist: Playlist([], index: 0)));
    }
  }
}
