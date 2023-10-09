import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_bloc.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_state.dart';
import 'package:smp/bloc/home_page_bloc/video_controls_logic/media_volume_bloc/media_volume_bloc.dart';
import 'package:smp/bloc/home_page_bloc/video_controls_logic/media_volume_bloc/media_volume_state.dart';
import 'package:smp/bloc/video_full_screen_bloc/video_fullscreen_cubit.dart';
import 'package:smp/ui/home_page/widgets/appbar_menu/appbar_menu_row.dart';
import 'package:smp/ui/home_page/widgets/appbar_menu/download_list.dart';
import 'package:smp/ui/home_page/widgets/media_controls/media_controls.dart';
import 'package:smp/ui/home_page/widgets/media_show/media_progress_show/media_progress_bar.dart';
import 'package:smp/ui/home_page/widgets/media_show/show_video_to_user.dart';
import 'package:smp/ui/home_page/widgets/media_volume/media_volume.dart';
import 'package:smp/ui/video_controls_bar/bottom_video_controls_bar.dart';
import 'package:smp/ui/video_controls_bar/fullscreen_change.dart';
import 'package:smp/ui/video_controls_bar/screen_fit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final fullScreen = BlocProvider.of<VideoFullscreenCubit>(context);

    return Scaffold(
      ///If the [fullScreen] global variable is true then,
      ///don't show the AppBar otherwise Show
      ///the [fullScreen] variable is declared in the
      ///package:smp/bloc/home_page_bloc/load_video_file/load_video_file_bloc.dart
      ///file
      appBar: fullScreen.state.isFullscreen
          ? null
          : AppBar(
              toolbarHeight: 35.0,
              leadingWidth: MediaQuery.of(context).size.width,
              leading:
                  Builder(builder: (context) => const HomePageAppBarMenu()),
              actions: const [
                ///For Showing the Download List and progress
                DownloadFileListAppBar()
              ],
            ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        ///If the [PickedMediaFile] state is empty then show the Launcher icon
        ///image, otherwise the Media file.
        child: BlocBuilder<SetupMediaFileToPlay, PickedMediaFile>(
            builder: (context, file) {
          if (file.videoFilePath.isEmpty) {
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
                    ///on Hovering the mouse then show a Control bar from bottom
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
                                    VideoControls(),
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
                                    const Icon(
                                      Icons.volume_up,
                                      size: 100.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "${volume.mediaVolume}",
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
          fullScreen.state.isFullscreen ? null : const BottomVideoControlsBar(),
    );
  }
}
