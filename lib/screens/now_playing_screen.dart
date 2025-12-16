import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final audio = context.watch<AudioProvider>();
    final song = audio.currentSong;

    return Scaffold(
      appBar: AppBar(title: const Text('Now Playing')),
      body: song == null
          ? const Center(child: Text('Chưa có bài hát'))
          : Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    height: 260,
                    width: 260,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade800,
                    ),
                    child: song.cover != null
                        ? Image.asset(song.cover!, fit: BoxFit.cover)
                        : const Icon(Icons.music_note,
                        size: 120, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  Text(song.title,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(song.artist,
                      style:
                      const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // SEEK
                Slider(
                  min: 0,
                  max: audio.duration.inSeconds.toDouble(),
                  value: audio.position.inSeconds
                      .clamp(0, audio.duration.inSeconds)
                      .toDouble(),
                  onChanged: (v) => audio.seek(
                      Duration(seconds: v.toInt())),
                ),

                Row(
                  children: [
                    Text(_fmt(audio.position)),
                    const Spacer(),
                    Text(_fmt(audio.duration)),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.shuffle,
                          color: audio.isShuffle
                              ? Colors.greenAccent
                              : Colors.white),
                      onPressed: audio.toggleShuffle,
                    ),
                    IconButton(
                      iconSize: 36,
                      icon: const Icon(Icons.skip_previous),
                      onPressed: audio.playPrevious,
                    ),
                    IconButton(
                      iconSize: 64,
                      icon: Icon(audio.isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled),
                      onPressed: audio.playPause,
                    ),
                    IconButton(
                      iconSize: 36,
                      icon: const Icon(Icons.skip_next),
                      onPressed: audio.playNext,
                    ),
                    IconButton(
                      icon: Icon(
                        audio.repeatMode == RepeatMode.one
                            ? Icons.repeat_one
                            : Icons.repeat,
                        color: audio.repeatMode != RepeatMode.off
                            ? Colors.greenAccent
                            : Colors.white,
                      ),
                      onPressed: audio.toggleRepeatMode,
                    ),

                    // 🔊 VOLUME ICON + SLIDER DỌC (KHÔNG LỆCH LAYOUT)
                    PopupMenuButton(
                      offset: const Offset(0, -180),
                      color: Colors.black87,
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          enabled: false,
                          child: SizedBox(
                            height: 140,
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: Slider(
                                value: audio.volume,
                                min: 0,
                                max: 1,
                                onChanged: audio.setVolume,
                              ),
                            ),
                          ),
                        ),
                      ],
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.volume_up),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(Duration d) {
    final m =
    d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s =
    d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}
