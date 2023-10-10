import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/media_volume_bloc/media_volume_bloc.dart';

class MediaVolumeWidget extends StatelessWidget {
  const MediaVolumeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //for adjust the volume of the Media
    final volume = BlocProvider.of<UpdateMediaVolume>(context);

    return Card(
      child: Row(
        children: [
          IconButton(
              onPressed: () async {
                ///call the [increaseVolume] method in the [UpdateMediaVolume]
                ///to increase the Volume of Media
                await volume.increaseVolume();
              },
              tooltip: "Increase Volume",
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () async {
                ///call the [decreaseVolume] method in the [UpdateMediaVolume]
                ///to decrease the Volume of Media
                await volume.decreaseVolume();
              },
              tooltip: "Decrease Volume",
              icon: const Icon(Icons.remove))
        ],
      ),
    );
  }
}
