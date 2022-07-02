import 'package:flutter/material.dart';
import 'package:ny_tunes/database/playlist_db.dart';
import 'package:ny_tunes/database/playlist_model.dart';
import 'package:ny_tunes/pages/home_.dart';
import 'package:ny_tunes/pages/player.dart';
import 'package:ny_tunes/pages/song_adding.dart';
import 'package:ny_tunes/settings/storage.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistData extends StatefulWidget {
  const PlaylistData({Key? key, required this.musicModel}) : super(key: key);
  final MusicModel musicModel;

  @override
  State<PlaylistData> createState() => _PlaylistDataState();
}

class _PlaylistDataState extends State<PlaylistData> {
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SafeArea(
                child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'Assets/images/defaultPlaylistImage-removebg-preview.png',
                        height: 150,
                        color: Colors.teal,
                      ),
                      Text(widget.musicModel.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const SongListPage()));
                          },
                          child: const Text('Add Songs')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Playlist.playlistFolder.value.isEmpty
                      ? const Center(
                          child: Text(
                            'No Song Found',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        )
                      : ValueListenableBuilder(
                          valueListenable: Playlist.playlistFolder,
                          builder: (BuildContext ctx,
                              List<SongModel> playlsitData, Widget? child) {
                            return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (ctx, index) {
                                  return ListTile(
                                      onTap: () {
                                        List<SongModel> newlist = [
                                          ...playlsitData
                                        ];
                                        setState(() {});
                                        Storage.player.setAudioSource(
                                            Storage.createSongList(newlist),
                                            initialIndex: index);
                                        Storage.player.play();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    PlayerPage(song: newlist)));
                                      },
                                      leading: QueryArtworkWidget(
                                        id: playlsitData[index].id,
                                        type: ArtworkType.AUDIO,
                                        errorBuilder: (context, excepion, gdb) {
                                          return Image.asset('');
                                        },
                                      ),
                                      title: Text(
                                        playlsitData[index].title,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      subtitle: Text(
                                        playlsitData[index].artist!,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      trailing: IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (builder) {
                                                  return Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            gradient: LinearGradient(
                                                                begin: Alignment
                                                                    .topCenter,
                                                                end: Alignment
                                                                    .bottomCenter,
                                                                colors: [
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          1,
                                                                          105,
                                                                          94),
                                                                  Colors.black,
                                                                  Colors.black,
                                                                ]),
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        25.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        25.0))),
                                                    child: SizedBox(
                                                      height: 350,
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
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
                                                                        .circular(
                                                                            1),
                                                                artworkWidth:
                                                                    100,
                                                                artworkHeight:
                                                                    400,
                                                                id: playlsitData[
                                                                        index]
                                                                    .id,
                                                                type:
                                                                    ArtworkType
                                                                        .AUDIO),
                                                          ),
                                                          const Text(
                                                            "jhgk",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 200,
                                                                    top: 90),
                                                            child: ElevatedButton
                                                                .icon(
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            Colors
                                                                                .transparent),
                                                                    onPressed:
                                                                        () {},
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .delete_outline_outlined,
                                                                      size: 25,
                                                                    ),
                                                                    label:
                                                                        const Text(
                                                                      'Remove Song',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20,
                                                                      ),
                                                                    )),
                                                          ),
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
                                itemCount: playlsitData.length);
                          },
                        ),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
