import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/data/video_subtitle_picker/video_subtitle_pick.dart';
import 'package:smp/dependency_injection/get_it_dependencies.dart';

part 'select_video_subtitle_state.dart';

class GetSubtitleFile extends Cubit<SubtitleFileState> {
  GetSubtitleFile() : super(const InitialSubtitleFileState(subtitlePath: null));

  ///Need the [VideoSubtitlePick] Data Provider to pick Subtitle from the
  ///Device.

  Future<void> getSubtitleFileFromDevice() async {
    try {
      String? path = await getIt<VideoSubtitlePick>().pickSubtitleFromDevice();
      if (path != null) {
        emit(SubtitleAddedSuccess(subtitlePath: File(path)));
      } else {
        emit(const SubtitleError(subtitlePath: null));
      }
    } on PlatformException catch (_) {
      emit(const SubtitleError(subtitlePath: null));
    }
  }
}
