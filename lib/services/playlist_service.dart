import '../models/playlist_model.dart';
import '../models/song_model.dart';

class PlaylistService {
  List<SongModel> getAllSongs() {
    return [
      SongModel(
        id: '1',
        title: 'Chất Gây Hại',
        artist: 'Quang Hùng MasterD, Low G ' ,
        path: 'assets/audio/sample_songs/chat_gay_hai.mp3',
        cover: 'assets/images/chat_gay_hai.jpg',
      ),
      SongModel(
        id: '2',
        title: 'Dễ Đến Dễ Đi',
        artist: 'Quang Hùng MasterD',
        path: 'assets/audio/sample_songs/de_den_de_di.mp3',
        cover: 'assets/images/de_den_de_di.jpg',
      ),
      SongModel(
        id: '3',
        title: 'Làn Ưu Tiên',
        artist: 'MOPIUS',
        path: 'assets/audio/sample_songs/lan_uu_tien.mp3',
        cover: 'assets/images/lan_uu_tien.jpg',
      ),
    ];
  }

  List<PlaylistModel> loadDemoPlaylists() {
    return [
      PlaylistModel(
        id: '1',
        name: 'My Playlist',
        songs: getAllSongs(),
      ),
    ];
  }
}
