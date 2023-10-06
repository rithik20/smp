import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/load_online_video/load_online_video_state.dart';

class PlayOnlineVideo extends Cubit<LoadOnlineVideoUrl>{
  PlayOnlineVideo() : super(LoadOnlineVideoUrl(url: ""));

  void getOnlineVideoUrl(String url){

    emit(LoadOnlineVideoUrl(url: state.url = url));
  }
}