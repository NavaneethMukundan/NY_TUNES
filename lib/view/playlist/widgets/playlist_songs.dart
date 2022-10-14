import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ny_tunes/model/Favorite_Button/favorite_btn.dart';

import 'package:ny_tunes/model/Playlist_Model/playlist_model.dart';
import 'package:ny_tunes/view/widgets/player.dart';
import 'package:ny_tunes/view/widgets/song_adding.dart';
import 'package:ny_tunes/controller/provider/main_functions/widgets/playlist_db.dart';
import 'package:ny_tunes/view/widgets/others/storage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlaylistData extends StatelessWidget {
  PlaylistData({Key? key, required this.playlist, required this.folderindex})
      : super(key: key);
  final MusicModel playlist;
  final int folderindex;
  late List<SongModel> playlistsong;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaylistDatabase>(context, listen: false);
    provider.getAllDetails();
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 1, 105, 94),
            Colors.black,
            Colors.black,
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SafeArea(
                child: Column(
              children: [
                Image.asset(
                  'Assets/images/defaultPlaylistImage-removebg-preview.png',
                  height: 150,
                  color: Colors.teal,
                ),
                Text(playlist.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: Colors.transparent),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => SongListPage(
                                playlist: playlist,
                              )));
                    },
                    child: const Text('Add Songs')),
                Consumer<PlaylistDatabase>(
                  builder: (context, value, child) {
                    Hive.box<MusicModel>('playlist').listenable();
                    playlistsong = listPlaylist(
                        value.musicListNotifier.toList()[folderindex].songData);

                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (ctx, index) {
                          return ListTile(
                              onTap: () {
                                List<SongModel> newlist = [...playlistsong];
                                Storage.player.setAudioSource(
                                    Storage.createSongList(newlist),
                                    initialIndex: index);
                                Storage.player.play();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) =>
                                        PlayerPage(playersong: newlist)));
                              },
                              leading: QueryArtworkWidget(
                                id: playlistsong[index].id,
                                type: ArtworkType.AUDIO,
                                errorBuilder: (context, excepion, gdb) {
                                  provider.notifyListeners();
                                  return Image.asset('');
                                },
                              ),
                              title: Text(
                                playlistsong[index].title,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              subtitle: Text(
                                playlistsong[index].artist!,
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (builder) {
                                          return Container(
                                            decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 1, 105, 94),
                                                      Colors.black,
                                                      Colors.black,
                                                    ]),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(25.0),
                                                    topRight:
                                                        Radius.circular(25.0))),
                                            child: SizedBox(
                                              height: 350,
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    height: 150,
                                                    width: 150,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors
                                                                .transparent),
                                                    child: QueryArtworkWidget(
                                                        artworkBorder:
                                                            BorderRadius
                                                                .circular(1),
                                                        artworkWidth: 100,
                                                        artworkHeight: 400,
                                                        id: playlistsong[index]
                                                            .id,
                                                        type:
                                                            ArtworkType.AUDIO),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      playlistsong[index].title,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            18.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ElevatedButton.icon(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary: Colors
                                                                        .transparent),
                                                            onPressed: () {
                                                              playlist.deleteData(
                                                                  playlistsong[
                                                                          index]
                                                                      .id);
                                                              provider
                                                                  .notifyListeners();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            icon: const Icon(
                                                              Icons
                                                                  .delete_outline_outlined,
                                                              size: 25,
                                                            ),
                                                            label: const Text(
                                                              'Remove Song',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                              ),
                                                            )),
                                                        Row(
                                                          children: [
                                                            FavorBtn(
                                                              song:
                                                                  playlistsong[
                                                                      index],
                                                            ),
                                                            const Text(
                                                              'Add to Favorite',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.more_vert_sharp,
                                    color: Colors.white,
                                  )));
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider();
                        },
                        itemCount: playlistsong.length);
                  },
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  List<SongModel> listPlaylist(List<int> data) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < Storage.songCopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (Storage.songCopy[i].id == data[j]) {
          plsongs.add(Storage.songCopy[i]);
        }
      }
    }
    return plsongs;
  }
}
