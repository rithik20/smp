import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/load_online_video/load_online_video_cubit.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/open_file_bloc/open_file_bloc_cubit.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_cubit.dart';
import 'package:smp/bloc/home_page_bloc/video_controls_logic/play_and_pause/play_pause_cubit.dart';
import 'package:smp/bloc/home_page_bloc/video_controls_logic/seek/video_seek_cubit.dart';
import 'package:smp/data/media_file_picker/video_file_picker.dart';
import 'package:smp/providers/text_controllers/text_controllers.dart';
import 'package:smp/providers/video_progress_stream/video_progress_stream.dart';
import 'package:smp/ui/home_page/home_page.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(const MediaPlayer());
}

class MediaPlayer extends StatelessWidget {
  const MediaPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context)=> TextControllers()),
        Provider(create: (context)=> VideoProgressStreamClass()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=> OpenFileFromDevice(VideoFilePickFromDevice())),
          BlocProvider(create: (context)=> PlayOnlineVideo()),
          BlocProvider(create: (context)=> StartVideoFile()),
          BlocProvider(create: (context)=> UpdateVideoPlayPause()),
          BlocProvider(create: (context)=> SeekToThisPosition()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: true),
          home: const HomePage(),
        ),
      ),
    );
  }
}
