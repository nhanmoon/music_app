import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({super.key});

  @override
  Widget build(BuildContext context) {
    final audio = context.watch<AudioProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous),
          iconSize: 40,
          onPressed: audio.playPrevious,
        ),
        IconButton(
          icon: Icon(
            audio.isPlaying
                ? Icons.pause_circle_filled
                : Icons.play_circle_filled,
          ),
          iconSize: 72,
          onPressed: audio.playPause,
        ),
        IconButton(
          icon: const Icon(Icons.skip_next),
          iconSize: 40,
          onPressed: audio.playNext,
        ),
      ],
    );
  }
}
