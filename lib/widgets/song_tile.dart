import 'package:flutter/material.dart';
import '../models/song_model.dart';

class SongTile extends StatelessWidget {
  final SongModel song;
  final VoidCallback onTap;

  const SongTile({
    super.key,
    required this.song,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: song.cover != null
            ? Image.asset(
          song.cover!,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
        )
            : Container(
          width: 48,
          height: 48,
          color: Colors.grey.shade800,
          child: const Icon(Icons.music_note, color: Colors.white),
        ),
      ),
      title: Text(song.title),
      subtitle: Text(song.artist),
      onTap: onTap,
    );
  }
}
