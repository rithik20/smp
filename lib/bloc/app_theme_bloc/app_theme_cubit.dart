import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  ///Passing the Initial state as Light Theme
  AppThemeCubit()
      : super(AppThemeInitial(appTheme: ThemeData.light(useMaterial3: true)));

  ///call this [changeToDarkTheme] method to change the App's
  ///Theme to Dark
  void changeToDarkTheme() {
    emit(DarkTheme(appTheme: ThemeData.dark(useMaterial3: true)));
  }

  ///call this [changeToLightTheme] method to change the App's
  ///Theme to Light
  void changeToLightTheme() {
    emit(LightTheme(appTheme: ThemeData.light(useMaterial3: true)));
  }
}
