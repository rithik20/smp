import 'package:file_picker/file_picker.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/open_file_bloc/open_file_bloc_cubit.dart';

class MediaFilePickFromDevice {
  ///This [pickMediaFileFromDevice] method will pick Any files from the
  ///Native Device. This method is called in the [OpenFileFromDevice] Cubit class
  Future<String?> pickMediaFileFromDevice() async {
    try {
      ///Pick Media files
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      return result!.files.first.path;
    } catch (_) {
      return null;
    }
  }
}
