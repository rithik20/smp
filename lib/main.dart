import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/load_online_video/load_online_video_cubit.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/open_file_bloc/open_file_bloc_cubit.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_bloc.dart';
import 'package:smp/bloc/home_page_bloc/select_video_subtitle/select_video_subtitle_cubit.dart';
import 'package:smp/bloc/home_page_bloc/video_controls_logic/media_volume_bloc/media_volume_bloc.dart';
import 'package:smp/bloc/home_page_bloc/video_controls_logic/play_and_pause/play_pause_cubit.dart';
import 'package:smp/bloc/home_page_bloc/video_controls_logic/seek/video_seek_cubit.dart';
import 'package:smp/bloc/media_progress_bloc/media_progress_bloc.dart';
import 'package:smp/bloc/video_full_screen_bloc/video_fullscreen_cubit.dart';
import 'package:smp/bloc/video_screen_fit_bloc/video_screen_fit_bloc.dart';
import 'package:smp/dependency_injection/get_it_dependencies.dart';
import 'package:smp/ui/home_page/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  MediaKit.ensureInitialized();
  //call the getIt singletons
  services();
  runApp(const MediaPlayer());
}

class MediaPlayer extends StatelessWidget {
  const MediaPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  OpenFileFromDevice()),
          BlocProvider(
              create: (context) => GetSubtitleFile()),
          BlocProvider(create: (context) => PlayOnlineVideo()),
          BlocProvider(create: (context) => MediaProgressBloc()),
          BlocProvider(create: (context) => SetupMediaFileToPlay()),
          BlocProvider(create: (context) => UpdateMediaPlayPause()),
          BlocProvider(create: (context) => SeekToThisPosition()),
          BlocProvider(create: (context) => ChangeVideoScreenFit()),
          BlocProvider(create: (context) => UpdateMediaVolume()),
          BlocProvider(create: (context) => VideoFullscreenCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: true),
          home: const HomePage(),
        ),
    );
  }
}
