part of 'video_screen_fit_bloc.dart';

@immutable
class VideoScreenFit {
  final BoxFit fit;

  final String screenFitString;

  final bool isVisible;

  const VideoScreenFit(
      {required this.fit,
      required this.screenFitString,
      required this.isVisible});
}

class InitialVideoScreenFit extends VideoScreenFit {
  const InitialVideoScreenFit(
      {required super.fit,
      required super.screenFitString,
      required super.isVisible});
}
