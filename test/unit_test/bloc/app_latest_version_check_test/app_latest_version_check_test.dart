import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:smp/bloc/app_latest_version_check/app_latest_version_check_cubit.dart';

import 'app_latest_version_check_test.mocks.dart';

@GenerateMocks([http.Client])
void main(){

  test("App Latest Version Check Test", () async {
    final client = MockClient();

    final AppLatestVersionCheckCubit appLatestVersionCheckCubit =
        AppLatestVersionCheckCubit();

    when(client.get(Uri.parse(
            "https://api.github.com/repos/rithik20/free_pdf_reader/releases/latest")))
        .thenAnswer((realInvocation) async => http.Response(
              "{}", 200));//passed

    await appLatestVersionCheckCubit.checkLatestVersion();

    expect(appLatestVersionCheckCubit.state.latestRelease, true);// passed

  });
}
