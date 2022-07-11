import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ny_tunes/database/playlist_database.dart';
import 'package:ny_tunes/database/playlist_model.dart';
import 'package:ny_tunes/pages/mini_player.dart';
import 'package:ny_tunes/pages/playlist_search.dart';
import 'package:ny_tunes/pages/playlist_songs.dart';
import '../settings/storage.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({
    Key? key,
  }) : super(key: key);
  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

final nameController = TextEditingController();

class _PlaylistPageState extends State<PlaylistPage> {
  @override
  Widget build(BuildContext context) {
    //getAllDetails();
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
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Text(
                        'Playlist',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: SizedBox(
                                      height: 250,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Center(
                                                child: Text(
                                              'Create Your Playlist',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            const SizedBox(
                                              height: 60,
                                            ),
                                            TextFormField(
                                                controller: nameController,
                                                decoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            ' Playlist Name'),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Value is Empty";
                                                  } else {
                                                    return null;
                                                  }
                                                }),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                                width: 350.0,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.teal),
                                                    onPressed: () {
                                                      whenButtonClicked();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Save')))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const PlaylistSearchPage()));
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box<MusicModel>('playlist').listenable(),
                  builder: (BuildContext context, Box<MusicModel> playlistDb,
                      Widget? child) {
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (ctx, index) {
                          final data = playlistDb.values.toList()[index];
                          return ListTile(
                            leading: Image.asset(
                                'Assets/images/defaultPlaylistImage-removebg-preview.png'),
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
                                                Image.asset(
                                                  'Assets/images/defaultPlaylistImage-removebg-preview.png',
                                                  height: 150,
                                                ),
                                                Text(
                                                  data.name,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 200, top: 90),
                                                  child: ElevatedButton.icon(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: Colors
                                                                  .transparent),
                                                      onPressed: () {
                                                        deletePlaylist(index);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .delete_outline_outlined,
                                                        size: 25,
                                                      ),
                                                      label: const Text(
                                                        'Remove Playlist',
                                                        style: TextStyle(
                                                          color: Colors.white,
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
                                icon: const Icon(
                                  Icons.more_vert_sharp,
                                  color: Colors.white,
                                )),
                            title: Text(
                              data.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return PlaylistData(
                                  folderindex: index,
                                  playlist: data,
                                );
                              }));
                            },
                          );
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider();
                        },
                        itemCount: playlistDb.length);
                  },
                ),
              ],
            ),
          )),
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

  Future<void> whenButtonClicked() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      return;
    } else {
      final music = MusicModel(name: name, songData: []);
      addPlaylist(music);
    }
  }
}
