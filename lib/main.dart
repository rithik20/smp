import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:smp/bloc/home_page_bloc/Menu_list_bloc/open_file_bloc/open_file_bloc_cubit.dart';
import 'package:smp/bloc/home_page_bloc/load_video_file/load_video_file_cubit.dart';
import 'package:smp/data/media_file_picker/video_file_picker.dart';
import 'package:smp/ui/home_page/home_page.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  final StartVideoFile startVideoFile = StartVideoFile();
  
  controller = await startVideoFile.loadVideoPlayer("");

  runApp(const MediaPlayer());
}

class MediaPlayer extends StatelessWidget {
  const MediaPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> OpenFileFromDevice(VideoFilePickFromDevice())),
        BlocProvider(create: (context)=> StartVideoFile()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        home: const HomePage(),
      ),
    );
  }
}
