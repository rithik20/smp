part of 'media_progress_bloc.dart';

@immutable
abstract class MediaProgressEvent {}

class StartProgress extends MediaProgressEvent{}

class StopProgress extends MediaProgressEvent{}
