import 'package:flutter/material.dart';
import 'package:ny_tunes/database/favorite_db.dart';
import 'package:ny_tunes/pages/mini_player.dart';
import 'package:ny_tunes/pages/player.dart';
import 'package:ny_tunes/settings/setting.dart';
import 'package:ny_tunes/settings/storage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import '../database/favorite_btn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static List<SongModel> songs = [];
  @override
  State<HomePage> createState() => _HomePageState();
}

final audioQuery = OnAudioQuery();

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Storage.player.currentIndexStream.listen((index) {});
    super.initState();
    requstPermission();
  }

  // @override
  // void dispose() {
  //   Storage.player.dispose();
  //   super.dispose();
  // }`
  void requstPermission() {
    Permission.storage.request();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
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
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Music',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 200,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const SettingPage()));
                          },
                          icon: const Icon(
                            Icons.more_horiz,
                            size: 30,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  FutureBuilder<List<SongModel>>(
                    future: audioQuery.querySongs(
                        sortType: null,
                        orderType: OrderType.ASC_OR_SMALLER,
                        uriType: UriType.EXTERNAL,
                        ignoreCase: true),
                    builder: (context, item) {
                      if (item.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (item.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            'NO Songs Found',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      HomePage.songs = item.data!;
                      if (!Favorite.isInitialized) {
                        Favorite.initialise(item.data!);
                      }
                      Storage.songCopy = item.data!;
                      // if (!Playlist.isInitialized) {
                      //   Playlist.initialise(item.data!);
                      // }

                      return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (ctx, index) {
                            return ListTile(
                              onTap: () async {
                                await Storage.player.setAudioSource(
                                    Storage.createSongList(item.data!),
                                    initialIndex: index);

                                if (Storage.currentindex != index) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) =>
                                          PlayerPage(playersong: item.data!)));
                                  Storage.player.play();
                                  setState(() {});
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          PlayerPage(playersong: item.data!)));
                                }
                              },
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: QueryArtworkWidget(
                                  id: item.data![index].id,
                                  type: ArtworkType.AUDIO),
                              title: Text(item.data![index].displayNameWOExt),
                              subtitle: Text("${item.data![index].artist}"),
                              trailing: SizedBox(
                                width: 30,
                                child: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (builder) {
                                            return Container(
                                              decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        Color.fromARGB(
                                                            255, 1, 105, 94),
                                                        Colors.black,
                                                        Colors.black,
                                                      ]),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  25.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  25.0))),
                                              child: SizedBox(
                                                height: 450,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                        height: 200,
                                                        width: 200,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Colors
                                                                    .transparent),
                                                        child:
                                                            QueryArtworkWidget(
                                                          artworkBorder:
                                                              BorderRadius
                                                                  .circular(1),
                                                          artworkWidth: 100,
                                                          artworkHeight: 400,
                                                          id: item
                                                              .data![index].id,
                                                          type:
                                                              ArtworkType.AUDIO,
                                                        )),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        item.data![index]
                                                            .displayNameWOExt,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Row(
                                                        children: [
                                                          FavorBtn(
                                                              song: item.data![
                                                                  index]),
                                                          const Text(
                                                            'Add to Favorite',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        bottom: 50,
                                                        right: 220,
                                                      ),
                                                      child:
                                                          ElevatedButton.icon(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      primary:
                                                                          Colors
                                                                              .transparent),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return Dialog(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.0)),
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              450,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(12.0),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const SizedBox(
                                                                                  height: 15,
                                                                                ),
                                                                                Container(
                                                                                    height: 100,
                                                                                    width: 100,
                                                                                    decoration: const BoxDecoration(color: Colors.transparent),
                                                                                    child: QueryArtworkWidget(
                                                                                      artworkBorder: BorderRadius.circular(1),
                                                                                      artworkWidth: 100,
                                                                                      artworkHeight: 400,
                                                                                      id: item.data![index].id,
                                                                                      type: ArtworkType.AUDIO,
                                                                                    )),
                                                                                const SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                                Text(item.data![index].displayNameWOExt),
                                                                                const SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                                Text("Artist :   ${item.data![index].artist}"),
                                                                                const SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .info_outlined,
                                                                size: 25,
                                                              ),
                                                              label: const Text(
                                                                'About Song',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20,
                                                                ),
                                                              )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    icon: const Icon(Icons.more_vert_sharp)),
                              ),
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return const Divider();
                          },
                          itemCount: item.data!.length);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 45),
          child: (Storage.player.currentIndex != null)
              ? const MiniPlayerPage(songs: [])
              : const SizedBox(),
        ),
      ),
    );
  }
}
// FavorBtn(
          //   song: HomePage.songs[Storage.player.currentIndex!],
          // ),
          // 
//ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //       shape: const CircleBorder(),
          //       primary: const Color.fromARGB(255, 27, 27, 27),
          //       onPrimary: Colors.white),
          //   onPressed: () async {
          //     if (Storage.player.playing) {
          //       await Storage.player.pause();
          //       setState(() {});
          //     } else {
          //       if (Storage.player.currentIndex != null) {
          //         await Storage.player.play();
          //       }
          //       setState(() {});
          //     }
          //   },
          //   child: StreamBuilder<bool>(
          //       stream: Storage.player.playingStream,
          //       builder: (context, snapshot) {
          //         bool? playingState = snapshot.data;
          //         if (playingState != null && playingState) {
          //           return const Icon(
          //             Icons.pause,
          //             size: 35,
          //           );
          //         } else {
          //           return const Icon(
          //             Icons.play_arrow,
          //             size: 35,
          //           );
          //         }
          //       }),
          // ),