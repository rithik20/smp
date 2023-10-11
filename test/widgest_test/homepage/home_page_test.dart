import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smp/bloc/app_theme_bloc/app_theme_cubit.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/video_full_screen_bloc/video_fullscreen_cubit.dart';
import 'package:smp/ui/home_page/home_page.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  ///Initialize the Hive Database
  await Hive.initFlutter();

  ///Open the Box named "smp", if not created it will create a new one
  ///the [smp] is a late LazyBox<dynamic> variable, declared in the [AppThemeCubit]
  ///class
  ///
  smp = await Hive.openLazyBox("smp");

  ///get the value of "theme" key from the Database
  ///if not found add a defaultValue to it
  ///the [theme] is a late String variable, declared in the [AppThemeCubit]
  ///class
  ///
  theme = await smp.get("theme", defaultValue: "light");

  ///If the [theme] gets the value of "dark" then assign
  ///[ThemeData.dark(useMaterial3: true)] to the [themeData] late ThemeData
  ///variable in the [AppThemeCubit], otherwise ThemeData.light(useMaterial3: true)
  ///
  if (theme == "dark") {
    themeData = ThemeData.dark(useMaterial3: true);
  } else {
    themeData = ThemeData.light(useMaterial3: true);
  }

  testWidgets("HomePage Test", (widgetTester) async {
    await widgetTester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppThemeCubit()),
        BlocProvider(create: (context) => VideoFullscreenCubit()),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    ));

    expect(find.byType(Scaffold), findsOneWidget);
  });
}
