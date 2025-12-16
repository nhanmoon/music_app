import 'package:flutter/material.dart';

import 'all_songs_screen.dart';
import 'playlist_screen.dart';
import 'settings_screen.dart';
import '../widgets/mini_player.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Music'),
        centerTitle: true,
      ),

      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.music_note),
            title: const Text('All Songs'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AllSongsScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.playlist_play),
            title: const Text('Playlists'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PlaylistScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),

      bottomNavigationBar: const MiniPlayer(),
    );
  }
}
