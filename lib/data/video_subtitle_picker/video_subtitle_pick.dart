import 'package:file_picker/file_picker.dart';
import 'package:smp/bloc/home_page_bloc/select_video_subtitle/select_video_subtitle_cubit.dart';

class VideoSubtitlePick{

  ///This [pickSubtitleFromDevice] will pick Subtitle from the Device, this method
  ///is called in the [GetSubtitleFile] Cubit class
  Future<String?> pickSubtitleFromDevice() async{

    try{
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['srt']
      );

      return result!.files.first.path;
    }catch(_){
      return null;
    }
  }
}