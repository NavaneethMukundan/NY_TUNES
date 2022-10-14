import 'package:flutter/material.dart';
import 'package:ny_tunes/view/widgets/player.dart';
import 'package:ny_tunes/controller/provider/main_functions/main_functions.dart';
import 'package:ny_tunes/view/widgets/others/storage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'others/storage.dart';

class MiniPlayerPage extends StatelessWidget {
  const MiniPlayerPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MiniPlayer>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Storage.player.currentIndexStream.listen((index) {
        provider.miniPlayer();
      });
    });
    Size deviceSize = MediaQuery.of(context).size;
    return Consumer<MiniPlayer>(
      builder: (context, value, child) {
        return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: const Color.fromARGB(255, 27, 27, 27),
            width: deviceSize.width,
            height: 70,
            child: ListTile(
              onTap: () {
                // Storage.player.setAudioSource(
                //     Storage.createSongList(Storage.songCopy),
                //     initialIndex: Storage.player.currentIndex);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => PlayerPage(
                          playersong: Storage.playingSongs,
                        )));
              },
              iconColor: Colors.white,
              textColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.only(left: 5),
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
                      id: Storage.playingSongs[Storage.player.currentIndex!].id,
                      type: ArtworkType.AUDIO,
                    )),
              ),
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  Storage.playingSongs[Storage.player.currentIndex!]
                      .displayNameWOExt,
                  style: const TextStyle(
                      fontSize: 16, overflow: TextOverflow.ellipsis),
                ),
              ),
              subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  "${Storage.playingSongs[Storage.player.currentIndex!].artist}",
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
                    provider.notifyListeners();
                  } else {
                    if (Storage.player.currentIndex != null) {
                      await Storage.player.play();
                    }
                    provider.notifyListeners();
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
      },
    );
  }
}
