import 'dart:io';
import 'package:flutter/services.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/open_file_bloc/open_file_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/data/media_file_picker/media_file_picker.dart';
import 'package:smp/dependency_injection/get_it_dependencies.dart';

class OpenFileFromDevice extends Cubit<FileFromDevice> {
  OpenFileFromDevice()
      : super(FileFromDevice(file: File("")));

  ///Need the [MediaFilePickFromDevice] Data Provider to pick the Media File from
  ///The device

  ///Open file using [file]
  Future<void> openTheFile() async {
    try {
      String? path =
          await getIt<MediaFilePickFromDevice>().pickMediaFileFromDevice();

      if(path != null) {
        ///Then emit the new state of the [FileFromDevice] class
        emit(FileFromDevice(file: state.file = File(path)));
      }else{
        emit(FileFromDevice(file: state.file = null));
      }

    } on PlatformException catch (_) {
      emit(FileFromDevice(file: state.file = null));
    }
  }
}
