import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/select_video_subtitle/select_video_subtitle_state.dart';
import 'package:smp/data/video_subtitle_picker/video_subtitle_pick.dart';
import 'package:smp/dependency_injection/get_it_dependencies.dart';

class GetSubtitleFile extends Cubit<SubtitleFileState>{
  GetSubtitleFile() : super(SubtitleFileState(subtitlePath: null));

  ///Need the [VideoSubtitlePick] Data Provider to pick Subtitle from the
  ///Device.

  Future<void> getSubtitleFileFromDevice() async{

    try{

      String? path = await getIt<VideoSubtitlePick>().pickSubtitleFromDevice();
      if(path != null){
        emit(SubtitleFileState(subtitlePath: state.subtitlePath = File(path)));
      }else{
        emit(SubtitleFileState(subtitlePath: state.subtitlePath = null));
      }
    }on PlatformException catch(_){

      emit(SubtitleFileState(subtitlePath: state.subtitlePath = null));
    }
  }
}