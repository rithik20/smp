import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:smp/bloc/app_theme_bloc/app_theme_cubit.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_media_files_cubit.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_media_files_state.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/media_volume_bloc/media_volume_bloc.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/video_full_screen_bloc/video_fullscreen_cubit.dart';
import 'package:smp/ui/home_page/widgets/appbar_menu/appbar_menu_row.dart';
import 'package:smp/ui/home_page/widgets/media_controls/media_controls.dart';
import 'package:smp/ui/home_page/widgets/media_show/media_progress_show/media_progress_bar.dart';
import 'package:smp/ui/home_page/widgets/media_show/show_video_to_user.dart';
import 'package:smp/ui/home_page/widgets/media_volume/media_volume.dart';
import 'package:smp/ui/home_page/widgets/video_controls_bar/bottom_video_controls_bar.dart';
import 'package:smp/ui/home_page/widgets/video_controls_bar/fullscreen_change.dart';
import 'package:smp/ui/home_page/widgets/video_controls_bar/screen_fit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //for changing the media screen state
    final fullScreen = BlocProvider.of<VideoFullscreenCubit>(context);

    //for changing the App Theme
    final appTheme = BlocProvider.of<AppThemeCubit>(context);

    return Scaffold(
      ///If the [isFullScreen] in the [VideoFullscreenState] state class
      ///variable is true then,
      ///
      ///don't show the AppBar otherwise Show
      ///the Appbar
      appBar: fullScreen.state.isFullscreen
          ? null
          : AppBar(
              toolbarHeight: 40.0,
              leadingWidth: MediaQuery.of(context).size.width,
              leading:
                  Builder(builder: (context) => const HomePageAppBarMenu()),
              actions: [
                ///Here using an Icon Button to switch the App's theme
                ///The Icons in this IconButton Widget will rebuilds
                ///as per the user interaction
                BlocBuilder<AppThemeCubit, AppThemeState>(
                    builder: (context, theme) => IconButton(
                        onPressed: () {
                          ///Check the App's Current Theme
                          ///and call the methods based on the AppTheme State
                          if (theme.appTheme ==
                              ThemeData.light(useMaterial3: true)) {
                            appTheme.changeToDarkTheme();
                          } else {
                            appTheme.changeToLightTheme();
                          }
                        },
                        icon: theme.appTheme ==
                                ThemeData.light(useMaterial3: true)
                            ? const Icon(Icons.dark_mode_outlined)
                            : const Icon(Icons.light_mode_outlined))),
              ],
            ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        ///If the [PickedMediaFile] state is empty then show the Launcher icon
        ///image, otherwise the Media file.
        child: BlocBuilder<SetupMediaFilesToPlay, PickedMediaFile>(
            builder: (context, file) {
          ///If the [videoFilePath], and [playlist] in the
          ///[PickedMediaFile] state class is not changed then it means
          ///no files selected by the user, so
          ///
          ///show the launcher icon to the user
          if (file.videoFilePath == "" && file.playlist == const Playlist([])) {
            return Center(
              child: Image.asset(
                "assets/launcher_icon/launcher_icon.png",
                width: 300,
                height: 300,
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            );
          } else {
            ///If the state value is not empty then,
            ///return the MouseRegion Widget with children
            ///Video Widget,VideoControls, and ProgressBar
            return BlocBuilder<VideoFullscreenCubit, VideoFullscreenState>(
              builder: (context, state) {
                return MouseRegion(

                    ///Only work the OnHover when the [isFullScreen] variable becomes true
                    ///on Hovering the mouse then show a Control bar using the
                    ///BottomSheet
                    onHover: state.isFullscreen
                        ? (v) {
                            showModalBottomSheet<void>(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              builder: (context) => const SizedBox(
                                height: 100,
                                child: Row(
                                  children: [
                                    MediaControls(),
                                    Flexible(child: MediaProgressBar()),
                                    MediaVolumeWidget(),
                                    FullscreenSwitchMode(),
                                    ScreenFitControl(),
                                  ],
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Stack(
                      children: [
                        ///Show the Media to User
                        const ShowMediaToUser(),

                        ///show Subtitle to the user
                        SubtitleView(
                            controller: VideoController(player,
                                configuration:
                                    const VideoControllerConfiguration()),
                            configuration:
                                const SubtitleViewConfiguration(visible: true)),

                        ///This [UpdateMediaVolume] BlocBuilder is for showing
                        ///the updated Volume in the UI.
                        BlocBuilder<UpdateMediaVolume, MediaVolumeState>(
                            builder: (context, volume) {
                          ///Returning an [AnimatedOpacity] Widget to show the
                          ///Volume in the UI, After 1 second the The Volume in the
                          ///UI Will removed
                          return AnimatedOpacity(
                              opacity: volume.isVisible ? 1.0 : 0.0,
                              duration: const Duration(seconds: 1),
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ///If the Volume is "0"
                                    ///it means that the Player Volume is muted
                                    ///then, show Volume Mute Icon, otherwise
                                    ///show Volume Up Icon
                                    if (volume.mediaVolume == 0) ...[
                                      const Icon(
                                        Icons.volume_mute,
                                        size: 100.0,
                                        color: Colors.white,
                                      ),
                                    ] else ...[
                                      const Icon(
                                        Icons.volume_up,
                                        size: 100.0,
                                        color: Colors.white,
                                      ),
                                    ],

                                    ///Show the Volume in the UI
                                    ///the [mediaVolume] in the [MediaVolumeState]
                                    ///state class is double, so round it to int
                                    Text(
                                      "${volume.mediaVolume.round()}",
                                      style: const TextStyle(
                                          fontSize: 100.0,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ));
                        }),
                      ],
                    ));
              },
            );
          }
        }),
      ),
      backgroundColor: Colors.black,

      ///using [BottomVideoControlsBar] as the BottomNavigationBar
      ///when user go to fullscreen remove the BottomAppBar
      bottomNavigationBar:
          fullScreen.state.isFullscreen ? null : const BottomMediaControlsBar(),
    );
  }
}
