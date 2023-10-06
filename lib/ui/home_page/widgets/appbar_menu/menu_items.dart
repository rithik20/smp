import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/load_online_video/load_online_video_cubit.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/open_file_bloc/open_file_bloc_cubit.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_cubit.dart';
import 'package:smp/providers/text_controllers/text_controllers.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    //For opening Files From Device using Menu List
    final openFile = BlocProvider.of<OpenFileFromDevice>(context);

    //For passing the Files path to Home Page
    final loadFile = BlocProvider.of<StartVideoFile>(context);

    final onlineFile = BlocProvider.of<PlayOnlineVideo>(context);

    final textController = Provider.of<TextControllers>(context);

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

        //Quit
        const PopupMenuItem(
            value: 2,
            child: Row(
              children: [Icon(Icons.exit_to_app_outlined), Text("Quit")],
            )),
      ],
      onSelected: (value) async {
        switch (value) {
          case 0:

            ///if the value is 0 then open the File From the Device
            await openFile.openTheFile();

            ///if the file path is updated then pass that file path as a String to
            ///loadVideoPlayer() in the StartVideoFile Cubit class
            if(openFile.state.file != null) {
              await loadFile.loadVideoPlayer(openFile.state.file!.path);
            }

            break;

          case 1:

            if(!context.mounted) return;
            await showDialog<void>(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      title: const Center(child: Text("Play Online Media")),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextField(
                              controller: textController.onlineUrl,
                              decoration: const InputDecoration(
                                hintText: "Enter or Paste URL",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0))
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ///For playing the Video using The URL
                                Column(
                                  children: [
                                    IconButton(onPressed: () async{
                                      onlineFile.getOnlineVideoUrl(textController.onlineUrl.value.text);
                                      await loadFile.loadVideoPlayer(onlineFile.state.url);
                                      if(!context.mounted) return;
                                      Navigator.pop(context);
                                    }, icon: const Icon(CupertinoIcons.play_circle, size: 45.0,)),
                                    const Text("Play Media")
                                  ],
                                ),
                                ///For Download the Video to Local Drive
                                Column(
                                  children: [
                                    IconButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, icon: const Icon(CupertinoIcons.down_arrow, size: 45.0,)),
                                    const Text("Download Media")
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
            );
        }
      },
    );
  }
}
