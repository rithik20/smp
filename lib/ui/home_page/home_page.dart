import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_cubit.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_state.dart';

import 'package:smp/ui/home_page/widgets/appbar_menu/appbar_menu_row.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //For opening Files From Device using Menu List
    final loadFile = BlocProvider.of<StartVideoFile>(context);

    return Scaffold(
        appBar: AppBar(
          leadingWidth: MediaQuery.of(context).size.width,
          leading: Builder(builder: (context) => const HomePageAppBarMenu()),
        ),
        body: BlocBuilder<StartVideoFile, LoadVideoFile>(
            builder: (context, file) {

            return Center(child: Text("Data"),);
        }));
  }
}
