import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_bloc.dart';
import 'package:smp/bloc/home_page_bloc/select_video_subtitle/select_video_subtitle_cubit.dart';

class SubtitleTrackMenu extends StatelessWidget {
  const SubtitleTrackMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final subtitle = BlocProvider.of<GetSubtitleFile>(context);

    return PopupMenuButton(
      icon: const Text("Subtitle"),
      itemBuilder: (context) => [
        const PopupMenuItem(value: 0, child: Text("Add Subtitle")),
      ],
      onSelected: (value) async {
        ///If the value is "0" which then show an Alert Box to User
        ///to select subtitle from their local Drive
        if (value == 0) {
          await showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Center(child: Text("Add Subtitle Track")),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          ///Add Subtitle using this Button
                          MaterialButton(
                            onPressed: () async {
                              await subtitle.getSubtitleFileFromDevice();
                              if (subtitle.state.subtitlePath != null) {
                                await player.setSubtitleTrack(
                                    SubtitleTrack.data(
                                        subtitle.state.subtitlePath!.path));
                                if (!context.mounted) return;
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("Select Subtitle File"),
                          )
                        ],
                      ),
                    ),
                  ));
        }
      },
    );
  }
}
