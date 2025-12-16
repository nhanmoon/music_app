import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();

  double _volume = 1.0;

  static const double _boostFactor = 1.5;

  AudioPlayerService() {
    _initAudioSession();
  }

  Future<void> _initAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    _applyVolume();
  }

  Future<void> load(String assetPath) async {
    await _player.setAsset(assetPath);
    _applyVolume();
  }

  Future<void> play() async => _player.play();
  Future<void> pause() async => _player.pause();
  Future<void> stop() async => _player.stop();

  void seek(Duration position) => _player.seek(position);

  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;

  bool get isPlaying => _player.playing;

  double get volume => _volume;

  void setVolume(double value) {
    _volume = value.clamp(0.0, 1.0);
    _applyVolume();
  }

  void _applyVolume() {
    final boosted = (_volume * _boostFactor).clamp(0.0, 1.8);
    _player.setVolume(boosted);
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
