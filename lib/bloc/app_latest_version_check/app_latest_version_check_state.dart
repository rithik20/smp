part of 'app_latest_version_check_cubit.dart';

@immutable
abstract class AppLatestVersionCheckState {
  final bool latestRelease;

  const AppLatestVersionCheckState({required this.latestRelease});
}

class AppLatestVersionCheckInitial extends AppLatestVersionCheckState {
  const AppLatestVersionCheckInitial({required super.latestRelease});
}

class AppLatestVersionFetchSuccess extends AppLatestVersionCheckState {
  const AppLatestVersionFetchSuccess({required super.latestRelease});
}

class AppLatestVersionAvailable extends AppLatestVersionCheckState {
  const AppLatestVersionAvailable({required super.latestRelease});
}

class NoLatestVersionAvailable extends AppLatestVersionCheckState {
  const NoLatestVersionAvailable({required super.latestRelease});
}

class AppLatestVersionFetchError extends AppLatestVersionCheckState {
  const AppLatestVersionFetchError({required super.latestRelease});
}
