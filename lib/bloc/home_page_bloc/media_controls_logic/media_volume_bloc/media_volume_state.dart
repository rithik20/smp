part of 'media_volume_bloc.dart';

@immutable
abstract class MediaVolumeState{

  final double mediaVolume;
  final bool isVisible;

  const MediaVolumeState({required this.mediaVolume, required this.isVisible});
}

class InitialMediaVolumeState extends MediaVolumeState{
  const InitialMediaVolumeState({required super.mediaVolume, required super.isVisible});
}

class MediaVolumeIncreased extends MediaVolumeState{
  const MediaVolumeIncreased({required super.mediaVolume, required super.isVisible});
}

class MediaVolumeDecreased extends MediaVolumeState{
  const MediaVolumeDecreased({required super.mediaVolume, required super.isVisible});
}