class PlaybackStateModel {
  final Duration position;
  final Duration duration;
  final bool isPlaying;

  PlaybackStateModel({
    required this.position,
    required this.duration,
    required this.isPlaying,
  });
}
