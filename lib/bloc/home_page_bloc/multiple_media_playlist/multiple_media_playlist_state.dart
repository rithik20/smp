part of 'multiple_media_playlist_cubit.dart';

@immutable
abstract class MultipleMediaPlaylistState {

  final Playlist playlist;

  const MultipleMediaPlaylistState({required this.playlist});
}

class MultipleMediaPlaylistInitial extends MultipleMediaPlaylistState {
  const MultipleMediaPlaylistInitial({required super.playlist});
}

class MultipleMediaPlaylistCreated extends MultipleMediaPlaylistState {
  const MultipleMediaPlaylistCreated({required super.playlist});
}

class MultipleMediaPlaylistError extends MultipleMediaPlaylistState {
  const MultipleMediaPlaylistError({required super.playlist});
}
