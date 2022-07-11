// import 'package:flutter/material.dart';
// import 'package:ny_tunes/database/playlist_db.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class PlaylistButton extends StatefulWidget {
//   const PlaylistButton({Key? key, required this.song}) : super(key: key);
//   final SongModel song;
//   @override
//   State<PlaylistButton> createState() => _PlaylistButtonState();
// }

// class _PlaylistButtonState extends State<PlaylistButton> {
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           if (Playlist.isplaylist(widget.song)) {
//             Playlist.delete(widget.song.id);
//             setState(() {});
//           }
//         },
//         icon: const Icon(Icons.add));
//   }
// }
