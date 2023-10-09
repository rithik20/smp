import 'package:get_it/get_it.dart';
import 'package:smp/data/media_file_picker/media_file_picker.dart';
import 'package:smp/data/video_subtitle_picker/video_subtitle_pick.dart';
import 'package:smp/dependency_injection/providers/media_progress_stream/media_progress_stream.dart';
import 'package:smp/dependency_injection/providers/text_controllers/text_controllers.dart';

final GetIt getIt = GetIt.instance;

void services(){

  getIt.registerSingleton<MediaProgressStream>(MediaProgressStream());
  getIt.registerSingleton<MediaFilePickFromDevice>(MediaFilePickFromDevice());
  getIt.registerSingleton<VideoSubtitlePick>(VideoSubtitlePick());
  getIt.registerSingleton<TextControllers>(TextControllers());
}