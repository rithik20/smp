import 'package:flutter/material.dart';
import 'package:smp/ui/home_page/home_page.dart';
import 'package:smp/ui/home_page/widgets/media_controls/media_controls.dart';
import 'package:smp/ui/home_page/widgets/media_show/media_progress_show/media_progress_bar.dart';
import 'package:smp/ui/home_page/widgets/media_volume/media_volume.dart';
import 'package:smp/ui/video_controls_bar/fullscreen_change.dart';
import 'package:smp/ui/video_controls_bar/screen_fit.dart';

///This [BottomMediaControlsBar] Widget is for Showing the Controls and it's
///Progress to the User. This Widget is used in the [HomePage] Widget's
///[bottomNavigationBar]
class BottomMediaControlsBar extends StatelessWidget {
  const BottomMediaControlsBar({super.key});

  ///return [BottomAppBar] instead of [BottomNavigationBar]
  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      child: Row(
        children: [
          MediaControls(),
          Flexible(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MediaProgressBar())),
          MediaVolumeWidget(),
          FullscreenSwitchMode(),
          ScreenFitControl()
        ],
      ),
    );
  }
}
