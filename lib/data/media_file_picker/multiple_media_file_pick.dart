import 'package:file_picker/file_picker.dart';

class MultipleMediaFilePicker {
  ///Call this [pickMultipleMediaFiles] method to pick multiple files from
  ///the Device
  Future<List<PlatformFile>?> pickMultipleMediaFiles() async {
    try {
      FilePickerResult? files = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: true);

      return files!.files;
    } catch (_) {
      return null;
    }
  }
}
