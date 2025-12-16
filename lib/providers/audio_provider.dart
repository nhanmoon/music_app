import 'dart:math';
import 'package:flutter/material.dart';
import '../models/song_model.dart';
import '../services/audio_player_service.dart';
import '../services/storage_service.dart';

enum RepeatMode { off, one, all }

class AudioProvider extends ChangeNotifier {
  final AudioPlayerService audio;
  final StorageService storage;

  List<SongModel> _playlist = [];
  int _currentIndex = 0;

  SongModel? currentSong;
  bool isPlaying = false;

  Duration position = Duration.zero;
  Duration duration = const Duration(seconds: 1);

  double volume = 1.0;

  bool isShuffle = false;
  RepeatMode repeatMode = RepeatMode.off;
  final _random = Random();

  AudioProvider(this.audio, this.storage) {
    _initListeners();
  }

  void _initListeners() {
    audio.positionStream.listen((p) {
      position = p;
      notifyListeners();
    });

    audio.durationStream.listen((d) {
      if (d != null) {
        duration = d;
        notifyListeners();
      }
    });
  }

  Future<void> setPlaylist(List<SongModel> songs,
      {int startIndex = 0}) async {
    if (songs.isEmpty) return;
    _playlist = songs;
    _currentIndex = startIndex.clamp(0, songs.length - 1);
    await _playCurrent();
  }

  Future<void> _playCurrent() async {
    currentSong = _playlist[_currentIndex];
    await audio.load(currentSong!.path);
    await audio.play();
    isPlaying = true;
    notifyListeners();
  }

  void playPause() {
    if (isPlaying) {
      audio.pause();
      isPlaying = false;
    } else {
      audio.play();
      isPlaying = true;
    }
    notifyListeners();
  }

  Future<void> playNext() async {
    if (_playlist.isEmpty) return;

    if (repeatMode == RepeatMode.one) {
      await _playCurrent();
      return;
    }

    if (isShuffle && _playlist.length > 1) {
      _currentIndex = _random.nextInt(_playlist.length);
    } else {
      _currentIndex++;
      if (_currentIndex >= _playlist.length) {
        if (repeatMode == RepeatMode.all) {
          _currentIndex = 0;
        } else {
          return;
        }
      }
    }

    await _playCurrent();
  }

  Future<void> playPrevious() async {
    if (position.inSeconds > 3) {
      seek(Duration.zero);
      return;
    }
    _currentIndex =
        (_currentIndex - 1 + _playlist.length) % _playlist.length;
    await _playCurrent();
  }

  void seek(Duration newPosition) {
    audio.seek(newPosition);
  }

  void setVolume(double value) {
    volume = value.clamp(0.0, 1.0);
    audio.setVolume(volume);
    notifyListeners();
  }

  void toggleShuffle() {
    isShuffle = !isShuffle;
    notifyListeners();
  }

  void toggleRepeatMode() {
    if (repeatMode == RepeatMode.off) {
      repeatMode = RepeatMode.one;
    } else if (repeatMode == RepeatMode.one) {
      repeatMode = RepeatMode.all;
    } else {
      repeatMode = RepeatMode.off;
    }
    notifyListeners();
  }
}
