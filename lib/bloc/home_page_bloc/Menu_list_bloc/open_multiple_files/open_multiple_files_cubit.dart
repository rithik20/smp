import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:smp/data/media_file_picker/multiple_media_file_pick.dart';
import 'package:smp/dependency_injection/get_it_dependencies.dart';

part 'open_multiple_files_state.dart';

class OpenMultipleFilesCubit extends Cubit<OpenMultipleFilesState> {
  OpenMultipleFilesCubit()
      : super(const OpenMultipleFilesInitial(mediaFilesList: []));

  Future<void> openMultipleMediaFiles() async {
    try {
      ///Try to pick multiple media files from the device using the
      ///[pickMultipleMediaFiles] method in the MultipleMediaFilePicker Data
      ///Provider
      final List<PlatformFile>? result =
          await getIt<MultipleMediaFilePicker>().pickMultipleMediaFiles();

      if (result != null) {
        ///if the result is not null then emit the Success State
        emit(OpenedMultipleFiles(mediaFilesList: result));
      } else {
        emit(const NoMultipleFiles(mediaFilesList: null));
      }
    } catch (_) {
      emit(const ErrorOpenMultipleFiles(mediaFilesList: null));
    }
  }
}
