import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/audio_provider.dart';
import '../services/playlist_service.dart';
import '../widgets/song_tile.dart';
import 'now_playing_screen.dart';

class AllSongsScreen extends StatefulWidget {
  const AllSongsScreen({super.key});

  @override
  State<AllSongsScreen> createState() => _AllSongsScreenState();
}

class _AllSongsScreenState extends State<AllSongsScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  late final songs = PlaylistService().loadDemoPlaylists().first.songs;

  @override
  Widget build(BuildContext context) {
    final filteredSongs = songs.where((song) {
      final q = _searchCtrl.text.toLowerCase();
      return song.title.toLowerCase().contains(q) ||
          song.artist.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Songs'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Tìm bài hát, ca sĩ...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.black54,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: filteredSongs.length,
            itemBuilder: (context, index) {
              return SongTile(
                song: filteredSongs[index],
                onTap: () {
                  context.read<AudioProvider>().setPlaylist(
                    filteredSongs,
                    startIndex: index,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NowPlayingScreen(),
                    ),
                  );
                },
              );
            },
          ),
          const _MiniPlayerBar(),
        ],
      ),
    );
  }
}


class _MiniPlayerBar extends StatelessWidget {
  const _MiniPlayerBar();

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (_, audio, __) {
        if (audio.currentSong == null) return const SizedBox();

        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.black87,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: audio.currentSong!.cover != null
                      ? Image.asset(
                    audio.currentSong!.cover!,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  )
                      : const Icon(Icons.music_note,
                      color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        audio.currentSong!.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        audio.currentSong!.artist,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    audio.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: audio.playPause,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
