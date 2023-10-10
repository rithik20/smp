part of 'open_multiple_files_cubit.dart';

@immutable
abstract class OpenMultipleFilesState {
  final List<PlatformFile>? mediaFilesList;
  const OpenMultipleFilesState({required this.mediaFilesList});
}

class OpenMultipleFilesInitial extends OpenMultipleFilesState {
  const OpenMultipleFilesInitial({required super.mediaFilesList});
}

class OpenedMultipleFiles extends OpenMultipleFilesState {
  const OpenedMultipleFiles({required super.mediaFilesList});
}

class NoMultipleFiles extends OpenMultipleFilesState {
  const NoMultipleFiles({required super.mediaFilesList});
}

class ErrorOpenMultipleFiles extends OpenMultipleFilesState {
  const ErrorOpenMultipleFiles({required super.mediaFilesList});
}
