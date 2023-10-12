import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:media_kit/media_kit.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smp/bloc/appBar_media_information/app_bar_media_information_cubit.dart';
import 'package:smp/bloc/app_latest_version_check/app_latest_version_check_cubit.dart';
import 'package:smp/bloc/app_theme_bloc/app_theme_cubit.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/open_file_bloc/open_file_bloc_cubit.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/open_multiple_files/open_multiple_files_cubit.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_media_files_cubit.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/media_play_pause_stream/media_play_pause_stream_bloc.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/media_progress_bloc/media_progress_bloc.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/media_volume_bloc/media_volume_bloc.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/seek/media_seek_cubit.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/video_full_screen_bloc/video_fullscreen_cubit.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/video_screen_fit_bloc/video_screen_fit_bloc.dart';
import 'package:smp/bloc/home_page_bloc/multiple_media_playlist/multiple_media_playlist_cubit.dart';
import 'package:smp/bloc/home_page_bloc/select_video_subtitle/select_video_subtitle_cubit.dart';
import 'package:smp/dependency_injection/get_it_dependencies.dart';
import 'package:smp/ui/home_page/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //ensure the [MediaKit] initialized
  MediaKit.ensureInitialized();

  //call the getIt singletons
  services();

  ///For getting the Package Information of this Application
  ///the [packageInfo] is a late variable is declared in the
  ///[smp/bloc/app_latest_version_check/app_latest_version_check_cubit.dart]
  packageInfo = await PackageInfo.fromPlatform();

  ///Initialize the Hive Database
  await Hive.initFlutter();

  ///Open the Box named "smp", if not created it will create a new one
  ///the [smp] is a late LazyBox<dynamic> variable, declared in the [AppThemeCubit]
  ///class, [smp/bloc/app_theme_bloc/app_theme_cubit.dart]
  ///
  smp = await Hive.openLazyBox("smp");

  ///get the value of "theme" key from the Database
  ///if not found add a defaultValue to it
  ///the [theme] is a late String variable, declared in the [AppThemeCubit]
  ///class, [smp/bloc/app_theme_bloc/app_theme_cubit.dart]
  ///
  theme = await smp.get("theme", defaultValue: "light");

  ///If the [theme] gets the value of "dark" then assign
  ///[ThemeData.dark(useMaterial3: true)] to the [themeData] late ThemeData
  ///variable in the [AppThemeCubit],[smp/bloc/app_theme_bloc/app_theme_cubit.dart]
  /// otherwise ThemeData.light(useMaterial3: true)
  ///
  if (theme == "dark") {
    themeData = ThemeData.dark(useMaterial3: true);
  } else {
    themeData = ThemeData.light(useMaterial3: true);
  }

  runApp(const SMPMediaPlayer());
}

class SMPMediaPlayer extends StatefulWidget {
  const SMPMediaPlayer({super.key});

  @override
  State<SMPMediaPlayer> createState() => _SMPMediaPlayerState();
}

class _SMPMediaPlayerState extends State<SMPMediaPlayer> {
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppThemeCubit()),
        BlocProvider(create: (context) => OpenFileFromDevice()),
        BlocProvider(create: (context) => OpenMultipleFilesCubit()),
        BlocProvider(create: (context) => MultipleMediaPlaylistCubit()),
        BlocProvider(create: (context) => GetSubtitleFile()),
        BlocProvider(create: (context) => MediaProgressBloc()),
        BlocProvider(create: (context) => SetupMediaFilesToPlay()),
        BlocProvider(create: (context) => MediaPlayPauseStreamBloc()),
        BlocProvider(create: (context) => SeekToThisPosition()),
        BlocProvider(create: (context) => ChangeVideoScreenFit()),
        BlocProvider(create: (context) => UpdateMediaVolume()),
        BlocProvider(create: (context) => VideoFullscreenCubit()),
        BlocProvider(create: (context) => AppBarMediaInformationCubit()),
        BlocProvider(create: (context) => AppLatestVersionCheckCubit()),
      ],

      ///Rebuild the App's Theme using the [AppThemeCubit] and it's
      ///[AppThemeState] state class's [appTheme] variable
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme.appTheme,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
