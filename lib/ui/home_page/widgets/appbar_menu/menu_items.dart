import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/load_online_video/load_online_video_cubit.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/open_file_bloc/open_file_bloc_cubit.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_bloc.dart';
import 'package:smp/bloc/home_page_bloc/video_controls_logic/play_and_pause/play_pause_cubit.dart';
import 'package:smp/bloc/media_progress_bloc/media_progress_bloc.dart';
import 'package:smp/dependency_injection/get_it_dependencies.dart';
import 'package:smp/dependency_injection/providers/text_controllers/text_controllers.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    //For opening Files From Device using Menu List
    final openFile = BlocProvider.of<OpenFileFromDevice>(context);

    //For passing the Files path to Home Page
    final loadFile = BlocProvider.of<SetupMediaFileToPlay>(context);

    //For playing the Media with the file path
    final playVideo = BlocProvider.of<UpdateMediaPlayPause>(context);

    //For showing the Media progress
    final mediaProgress = BlocProvider.of<MediaProgressBloc>(context);

    final onlineFile = BlocProvider.of<PlayOnlineVideo>(context);

    return PopupMenuButton(
      icon: const Text("Menu"),
      itemBuilder: (context) => [
        //Open File
        const PopupMenuItem(
            value: 0,
            child: Row(
              children: [Icon(Icons.file_open_outlined), Text("Open File")],
            )),

        const PopupMenuItem(
            value: 1,
            child: Row(
              children: [Icon(CupertinoIcons.link), Text("Open URL")],
            )),
      ],
      onSelected: (value) async {
        switch (value) {
          case 0:

            ///if the value is 0 then open the File From the Device
            await openFile.openTheFile();

            ///if the file path is updated then pass that file path String to
            ///[initializeMediaPlayer()] in the [SetupMediaFileToPlay] Cubit class
            if (openFile.state.file != null) {
              await loadFile.initializeMediaPlayer(openFile.state.file!.path);

              ///If the player ready to play the video, then play the
              ///video with the path, using the [playVideo()] in the
              ///[UpdateMediaPlayPause] Cubit class
              await playVideo.playVideo();

              ///also show the Media progress in the Bar
              mediaProgress.add(StartProgress());
            }

            break;

          case 1:
            if (!context.mounted) return;
            await showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Center(child: Text("Play Online Media")),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextField(
                              controller: getIt<TextControllers>().onlineUrl,
                              decoration: const InputDecoration(
                                hintText: "Enter or Paste URL",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ///For playing the Video using The URL
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          onlineFile.getOnlineVideoUrl(
                                              getIt<TextControllers>()
                                                  .onlineUrl
                                                  .value
                                                  .text);
                                          await loadFile.initializeMediaPlayer(
                                              onlineFile.state.url);
                                          if (!context.mounted) return;
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          CupertinoIcons.play_circle,
                                          size: 45.0,
                                        )),
                                    const Text("Play Media")
                                  ],
                                ),

                                ///For Download the Video to Local Drive
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          CupertinoIcons.down_arrow,
                                          size: 45.0,
                                        )),
                                    const Text("Download Media")
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
            break;
        }
      },
    );
  }
}
