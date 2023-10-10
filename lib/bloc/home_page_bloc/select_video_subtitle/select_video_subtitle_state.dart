part of 'select_video_subtitle_cubit.dart';

@immutable
abstract class SubtitleFileState{

  final File? subtitlePath;

  const SubtitleFileState({required this.subtitlePath});
}

class InitialSubtitleFileState extends SubtitleFileState{
  const InitialSubtitleFileState({required super.subtitlePath});
}

class SubtitleAddedSuccess extends SubtitleFileState{
  const SubtitleAddedSuccess({required super.subtitlePath});
}

class SubtitleError extends SubtitleFileState{
  const SubtitleError({required super.subtitlePath});
}