import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

@immutable
abstract class PickedMediaFile {
  final String? videoFilePath;

  final VideoController controller;

  final Playlist? playlist;

  const PickedMediaFile(
      {required this.videoFilePath,
      required this.controller,
      required this.playlist});
}

class InitialPickedMediaFile extends PickedMediaFile {
  const InitialPickedMediaFile(
      {required super.videoFilePath,
      required super.controller,
      required super.playlist});
}

class MediaPlayingSuccess extends PickedMediaFile {
  const MediaPlayingSuccess(
      {required super.videoFilePath,
      required super.controller,
      required super.playlist});
}

class MediaPlayingError extends PickedMediaFile {
  const MediaPlayingError(
      {required super.videoFilePath,
        required super.controller,
        required super.playlist});
}