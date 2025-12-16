class SongModel {
  final String id;
  final String title;
  final String artist;
  final String path;
  final Duration? duration;

  final String? cover;

  SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.path,
    this.duration,
    this.cover,
  });
}
