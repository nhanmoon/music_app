import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

class MusicProgressBar extends StatelessWidget {
  const MusicProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final audio = context.watch<AudioProvider>();

    return StreamBuilder<Duration>(
      stream: audio.audio.positionStream,
      builder: (context, positionSnapshot) {
        final position = positionSnapshot.data ?? Duration.zero;

        return StreamBuilder<Duration?>(
          stream: audio.audio.durationStream,
          builder: (context, durationSnapshot) {
            final duration = durationSnapshot.data ?? Duration.zero;

            return Column(
              children: [
                Slider(
                  value: position.inMilliseconds.toDouble().clamp(
                    0,
                    duration.inMilliseconds.toDouble(),
                  ),
                  max: duration.inMilliseconds.toDouble() == 0
                      ? 1
                      : duration.inMilliseconds.toDouble(),
                  onChanged: (value) {
                    audio.seek(Duration(milliseconds: value.toInt()));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_format(position)),
                      Text(_format(duration)),
                    ],
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  String _format(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
