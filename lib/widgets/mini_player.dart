import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import '../screens/now_playing_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final audio = context.watch<AudioProvider>();

    if (audio.currentSong == null) return const SizedBox();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const NowPlayingScreen(),
          ),
        );
      },
      child: Container(
        color: Colors.grey[900],
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.music_note),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                audio.currentSong!.title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: Icon(
                audio.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
              onPressed: audio.playPause,
            ),
          ],
        ),
      ),
    );
  }
}
