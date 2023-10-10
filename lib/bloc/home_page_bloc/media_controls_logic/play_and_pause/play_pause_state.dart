part of 'play_pause_cubit.dart';

@immutable
class MediaPlayPause{

  final bool isPlaying;

  const MediaPlayPause({required this.isPlaying});
}

class MediaPlaying extends MediaPlayPause{
  const MediaPlaying({required super.isPlaying});
}

class MediaPaused extends MediaPlayPause{
  const MediaPaused({required super.isPlaying});
}