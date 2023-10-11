part of 'media_progress_bloc.dart';

@immutable
abstract class MediaProgressState {
  final Duration duration;

  const MediaProgressState({required this.duration});
}

class MediaProgressInitial extends MediaProgressState {
  const MediaProgressInitial({required super.duration});
}

class MediaProgressStarted extends MediaProgressState {
  const MediaProgressStarted({required super.duration});
}

class MediaProgressError extends MediaProgressState{
  const MediaProgressError({required super.duration});
}

class MediaProgressStopped extends MediaProgressState {
  const MediaProgressStopped({required super.duration});
}

class MediaProgressCompleted extends MediaProgressState {
  const MediaProgressCompleted({required super.duration});
}
