import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smp/main.dart';

part 'app_theme_state.dart';

///These [smp], [theme], and the [themeData] variables will assigned
///in the [main] method
late LazyBox<dynamic> smp;
late String theme;
late ThemeData themeData;

class AppThemeCubit extends Cubit<AppThemeState> {
  ///Passing the Initial state from the Hive Database
  ///the [themeData] gets value from the [main] method
  AppThemeCubit() : super(AppThemeInitial(appTheme: themeData));

  ///call this [changeToDarkTheme] method to change the App's
  ///Theme to Dark
  void changeToDarkTheme() {
    emit(DarkTheme(appTheme: ThemeData.dark(useMaterial3: true)));

    ///also update the the AppTheme state to Dark Mode in the Database
    smp.put('theme', "dark");
  }

  ///call this [changeToLightTheme] method to change the App's
  ///Theme to Light
  void changeToLightTheme() {
    emit(LightTheme(appTheme: ThemeData.light(useMaterial3: true)));

    ///also update the the AppTheme state to Light Mode in the Database
    smp.put("theme", "light");
  }
}
