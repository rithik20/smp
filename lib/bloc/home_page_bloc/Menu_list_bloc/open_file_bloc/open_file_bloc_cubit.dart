import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/open_file_bloc/open_file_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/data/media_file_picker/video_file_picker.dart';

class OpenFileFromDevice extends Cubit<FileFromDevice> {
  OpenFileFromDevice(this.videoFilePickFromDevice)
      : super(FileFromDevice(file: File("")));

  ///Need the [VideoFilePickFromDevice] Data Provider to pick the Video File from
  ///The device
  final VideoFilePickFromDevice videoFilePickFromDevice;

  ///Open file using [file]
  Future<void> openTheFile() async {
    try{
      FilePickerResult? file = await videoFilePickFromDevice.pickVideoFileFromDevice();
      ///Then emit the new state of the [FileFromDevice] class
      emit(FileFromDevice(file: state.file = File(file!.files.first.path!)));
    }catch(_){
      throw _.toString();
    }
  }
}
