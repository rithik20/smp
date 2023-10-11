part of 'media_play_pause_stream_bloc.dart';

@immutable
abstract class MediaPlayPauseStreamState {

  final bool isPlaying;

  const MediaPlayPauseStreamState({required this.isPlaying});
}

class MediaPlayPauseStreamInitial extends MediaPlayPauseStreamState {
  const MediaPlayPauseStreamInitial({required super.isPlaying});
}

class MediaPlaying extends MediaPlayPauseStreamState {
  const MediaPlaying({required super.isPlaying});
}

class MediaPaused extends MediaPlayPauseStreamState {
  const MediaPaused({required super.isPlaying});
}
