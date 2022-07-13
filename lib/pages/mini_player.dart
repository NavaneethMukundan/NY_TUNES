import 'package:flutter/material.dart';
import 'package:ny_tunes/pages/home_.dart';
import 'package:ny_tunes/pages/player.dart';
import 'package:ny_tunes/storage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../storage.dart';

class MiniPlayerPage extends StatefulWidget {
  const MiniPlayerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MiniPlayerPage> createState() => _MiniPlayerPageState();
}

class _MiniPlayerPageState extends State<MiniPlayerPage> {
  @override
  void initState() {
    Storage.player.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  final List<SongModel> song = [];
  final index = Storage.player.currentIndex!;
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: const Color.fromARGB(255, 27, 27, 27),
        width: deviceSize.width,
        height: 70,
        child: ListTile(
          onTap: () {
            Storage.player.setAudioSource(Storage.createSongList(song),
                initialIndex: index);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => PlayerPage(
                      playersong: HomePage.songs,
                    )));
          },
          iconColor: Colors.white,
          textColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
                height: 55,
                width: 55,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: QueryArtworkWidget(
                  artworkBorder: BorderRadius.circular(10),
                  artworkWidth: 100,
                  artworkHeight: 400,
                  id: HomePage.songs[Storage.player.currentIndex!].id,
                  type: ArtworkType.AUDIO,
                )),
          ),
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              HomePage.songs[Storage.player.currentIndex!].displayNameWOExt,
              style: const TextStyle(
                  fontSize: 16, overflow: TextOverflow.ellipsis),
            ),
          ),
          subtitle: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${HomePage.songs[Storage.player.currentIndex!].artist}",
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 11,
              ),
            ),
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                primary: const Color.fromARGB(255, 27, 27, 27),
                onPrimary: Colors.white),
            onPressed: () async {
              if (Storage.player.playing) {
                await Storage.player.pause();
                setState(() {});
              } else {
                if (Storage.player.currentIndex != null) {
                  await Storage.player.play();
                }
                setState(() {});
              }
            },
            child: StreamBuilder<bool>(
                stream: Storage.player.playingStream,
                builder: (context, snapshot) {
                  bool? playingState = snapshot.data;
                  if (playingState != null && playingState) {
                    return const Icon(
                      Icons.pause,
                      size: 35,
                    );
                  } else {
                    return const Icon(
                      Icons.play_arrow,
                      size: 35,
                    );
                  }
                }),
          ),
        ));
  }
}
