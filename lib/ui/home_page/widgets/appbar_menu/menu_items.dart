import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/open_file_bloc/open_file_bloc_cubit.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/open_multiple_files/open_multiple_files_cubit.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_media_files_cubit.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/play_and_pause/play_pause_cubit.dart';
import 'package:smp/bloc/home_page_bloc/multiple_media_playlist/multiple_media_playlist_cubit.dart';
import 'package:smp/bloc/media_progress_bloc/media_progress_bloc.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    //For opening Files From Device using Menu List
    final openFile = BlocProvider.of<OpenFileFromDevice>(context);

    //for opening multiple media files
    final openMultipleFiles = BlocProvider.of<OpenMultipleFilesCubit>(context);

    //for setup the playlist for media files
    final multipleFilesPlaylist =
        BlocProvider.of<MultipleMediaPlaylistCubit>(context);

    //For loading the Medias
    final loadFile = BlocProvider.of<SetupMediaFilesToPlay>(context);

    //For playing the Medias
    final playMedia = BlocProvider.of<UpdateMediaPlayPause>(context);

    //For showing the Media progress
    final mediaProgress = BlocProvider.of<MediaProgressBloc>(context);

    return PopupMenuButton(
      icon: const Text("Menu"),
      itemBuilder: (context) => [
        //Open File
        const PopupMenuItem(
            value: 0,
            child: Row(
              children: [Icon(Icons.file_open_outlined), Text("Open File")],
            )),

        //open multiple files
        const PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                Icon(Icons.file_open_rounded),
                Text("Open Multiple Files")
              ],
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
              await loadFile
                  .initializeSingleFileMediaPlayer(openFile.state.file!.path);

              ///If the player ready to play the media, then play the
              ///media with the path, using the [playMedia()] in the
              ///[UpdateMediaPlayPause] Cubit class
              await playMedia.playMedia();

              ///also show the Media progress in the Bar
              mediaProgress.add(StartProgress());
            }

            break;

          case 1:

            ///await the File picker to open Multiple Files
            ///from the device
            await openMultipleFiles.openMultipleMediaFiles();

            ///if the state of [OpenMultipleFiles] is not null then/
            ///
            /// pass that state to the [addAllMediasToPlaylist] method
            /// in the [MultipleMediaPlaylistCubit] class
            /// to change the State of [MultipleMediaPlaylistState]
            if (openMultipleFiles.state.mediaFilesList!.isNotEmpty) {
              multipleFilesPlaylist.addAllMediasToPlaylist(
                  openMultipleFiles.state.mediaFilesList);

              ///and finally start the Medias one by one using
              ///the new state of [MultipleMediaPlaylistState]'s Playlist
              await loadFile.initializeMultipleMediaPlayer(
                  multipleFilesPlaylist.state.playlist);

              ///and play the Medias
              await playMedia.playMedia();

              ///also show the Medias progress in the Bar
              mediaProgress.add(StartProgress());
            }
        }
      },
    );
  }
}
