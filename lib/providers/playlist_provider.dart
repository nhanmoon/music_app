import 'package:flutter/material.dart';
import '../models/playlist_model.dart';
import '../services/playlist_service.dart';

class PlaylistProvider extends ChangeNotifier {
  final _service = PlaylistService();
  late List<PlaylistModel> playlists;

  PlaylistProvider() {
    playlists = _service.loadDemoPlaylists();
  }
}
