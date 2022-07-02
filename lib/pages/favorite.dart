import 'package:flutter/material.dart';
import 'package:ny_tunes/database/favorite_db.dart';
import 'package:ny_tunes/pages/player.dart';
import 'package:ny_tunes/settings/storage.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({
    Key? key,
  }) : super(key: key);
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 180),
                      child: Text(
                        'Liked Songs',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Favorite.favoriteSong.value.isEmpty
                          ? const Center(
                              child: Text(
                                'No Song Found',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            )
                          : ValueListenableBuilder(
                              valueListenable: Favorite.favoriteSong,
                              builder: (BuildContext ctx,
                                  List<SongModel> favorData, Widget? child) {
                                return ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (ctx, index) {
                                      return ListTile(
                                        onTap: () {
                                          List<SongModel> newlist = [
                                            ...favorData
                                          ];
                                          setState(() {});
                                          Storage.player.setAudioSource(
                                              Storage.createSongList(newlist),
                                              initialIndex: index);
                                          Storage.player.play();
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) => PlayerPage(
                                                      song: newlist)));
                                        },
                                        leading: QueryArtworkWidget(
                                          id: favorData[index].id,
                                          type: ArtworkType.AUDIO,
                                          errorBuilder:
                                              (context, excepion, gdb) {
                                            return Image.asset('');
                                          },
                                        ),
                                        title: Text(
                                          favorData[index].title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        subtitle: Text(
                                          favorData[index].artist!,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        trailing: const Icon(
                                          Icons.more_vert_rounded,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                    separatorBuilder: (ctx, index) {
                                      return const Divider();
                                    },
                                    itemCount: favorData.length);
                              },
                            ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
