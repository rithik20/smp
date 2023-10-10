part of 'app_theme_cubit.dart';

@immutable
abstract class AppThemeState {

  final ThemeData appTheme;

  const AppThemeState({required this.appTheme});
}

class AppThemeInitial extends AppThemeState {
  const AppThemeInitial({required super.appTheme});
}

class DarkTheme extends AppThemeState {
  const DarkTheme({required super.appTheme});
}

class LightTheme extends AppThemeState {
  const LightTheme({required super.appTheme});
}
