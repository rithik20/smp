import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_cubit.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_state.dart';
import 'package:smp/ui/home_page/widgets/appbar_menu/appbar_menu_row.dart';
import 'package:smp/ui/home_page/widgets/appbar_menu/download_list.dart';
import 'package:smp/ui/home_page/widgets/video_show/show_video_to_user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///If the [fullScreen] global variable is true then,
      ///don't show the AppBar otherwise Show
      ///the [fullScreen] variable is declared in the
      ///package:smp/bloc/home_page_bloc/load_video_file/load_video_file_cubit.dart
      ///file
      appBar: fullScreen
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
        child: BlocBuilder<StartVideoFile, LoadVideoFile>(
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
            ///return the Video Widget,VideoControls, and ProgressBar
            return const ShowVideoToUser();
          }
        }),
      ),
      backgroundColor: Colors.black,
    );
  }
}
