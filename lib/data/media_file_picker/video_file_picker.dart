import 'package:file_picker/file_picker.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/open_file_bloc/open_file_bloc_cubit.dart';

class VideoFilePickFromDevice{

  ///This [pickVideoFileFromDevice] method will pick only Video files from the
  ///Native Device. This method is called in the [OpenFileFromDevice] Cubit class
  Future<String?> pickVideoFileFromDevice() async{
    try{
      ///Only Pick Video files
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
      );

      return result!.files.first.path;

    }catch(_){
      return null;
    }
  }
}