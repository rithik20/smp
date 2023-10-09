import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:smp/main.dart';
import 'package:smp/ui/home_page/home_page.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();

  testWidgets("MediaPlayer Widget Test", (widgetTester) async{

    await widgetTester.pumpWidget(const MediaPlayer());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
  });
}