import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'app_latest_version_check_state.dart';

late PackageInfo packageInfo;

class AppLatestVersionCheckCubit extends Cubit<AppLatestVersionCheckState> {
  AppLatestVersionCheckCubit()
      : super(const AppLatestVersionCheckInitial(latestRelease: false));

  ///call this [checkLatestVersion] method to check the updates about
  ///Application
  Future<void> checkLatestVersion() async {
    try {
      ///Check the Releases in Github
      final response = await http.get(Uri.parse(
          "https://api.github.com/repos/rithik20/free_pdf_reader/releases/latest"));

      if (response.statusCode == 200) {
        ///If the API call return 200 Status Code!
        ///then emit the [AppLatestVersionFetchSuccess] state
        emit(const AppLatestVersionFetchSuccess(latestRelease: false));

        ///The response.body in a String form first decode it to a Map
        final Map<String, dynamic> responseMap = jsonDecode(response.body);

        ///Then get the 'tag_name' Key's value
        String tag = responseMap['tag_name'];

        ///Remove the 'v' from that tag
        String version = tag.toString().replaceFirst("v", '');

        ///Compare the Versions using [package_info_plus] package's
        ///PackageInfo class
        if (version != packageInfo.version) {
          Timer(const Duration(seconds: 2), () {
            ///If the versions not matching then Update Available!!
            emit(const AppLatestVersionAvailable(latestRelease: true));
          });
        } else {
          Timer(const Duration(seconds: 2), () {
            ///If matching then No Updates Available!
            emit(const NoLatestVersionAvailable(latestRelease: false));
          });
        }
      }
    } catch (_) {
      emit(const AppLatestVersionFetchError(latestRelease: false));
    }
  }
}
