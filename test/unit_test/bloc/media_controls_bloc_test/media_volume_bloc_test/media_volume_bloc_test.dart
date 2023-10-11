import 'package:flutter_test/flutter_test.dart';
import 'package:media_kit/media_kit.dart';
import 'package:smp/bloc/home_page_bloc/media_controls_logic/media_volume_bloc/media_volume_bloc.dart';

void main() {
  setUp(() => MediaKit.ensureInitialized());

  test("Media Volume Test", () async {
    final UpdateMediaVolume updateMediaVolume = UpdateMediaVolume();

    ///Initial state of Volume
    expect(updateMediaVolume.state.isVisible, false); //passed
    expect(updateMediaVolume.state.mediaVolume, 100.0); //passed

    ///Increasing the volume
    await updateMediaVolume.increaseVolume();
    expect(updateMediaVolume.state.isVisible, true); //passed
    expect(updateMediaVolume.state.mediaVolume, 110); //passed

    ///Decreasing the Volume
    await updateMediaVolume.decreaseVolume();
    expect(updateMediaVolume.state.isVisible, true); //passed
    expect(updateMediaVolume.state.mediaVolume, 100); //passed
  });
}
