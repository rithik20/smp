part of 'video_fullscreen_cubit.dart';

@immutable
abstract class VideoFullscreenState {
  final bool isFullscreen;

  const VideoFullscreenState({required this.isFullscreen});
}

class VideoFullscreenInitial extends VideoFullscreenState {
  const VideoFullscreenInitial({required super.isFullscreen});
}

class FullscreenMode extends VideoFullscreenState {
  const FullscreenMode({required super.isFullscreen});
}

class FullscreenExited extends VideoFullscreenState {
  const FullscreenExited({required super.isFullscreen});
}
