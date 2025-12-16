import 'song_model.dart';

class PlaylistModel {
  final String id;
  final String name;
  final List<SongModel> songs;

  PlaylistModel({
    required this.id,
    required this.name,
    required this.songs,
  });
}
