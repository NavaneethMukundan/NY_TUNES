import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ny_tunes/model/Playlist_Model/playlist_model.dart';
import 'package:ny_tunes/view/playlist/widgets/playlist_search.dart';
import 'package:ny_tunes/view/playlist/widgets/playlist_songs.dart';
import 'package:ny_tunes/controller/provider/main_functions/main_functions.dart';
import 'package:ny_tunes/controller/provider/main_functions/widgets/playlist_db.dart';
import 'package:provider/provider.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({
    Key? key,
  }) : super(key: key);

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
                                                controller: Provider.of<
                                                            PlaylistFunctionController>(
                                                        context)
                                                    .nameController,
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
                                                      Provider.of<PlaylistFunctionController>(
                                                              context,
                                                              listen: false)
                                                          .whenButtonClicked(
                                                              context);
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
                Consumer<PlaylistDatabase>(
                  builder: (context, playlistDb, child) {
                    Hive.box<MusicModel>('playlist').listenable();
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (ctx, index) {
                          final data =
                              playlistDb.musicListNotifier.toList()[index];
                          // playlistDb.musicListNotifier.toList()[index];
                          return ListTile(
                            leading: Image.asset(
                                'Assets/images/defaultPlaylistImage-removebg-preview.png'),
                            trailing: IconButton(
                                onPressed: () {
                                  BottomSheet(context, data, provider, index);
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
                        itemCount: playlistDb.musicListNotifier.length);
                  },
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Future<dynamic> BottomSheet(BuildContext context, MusicModel data, PlaylistDatabase provider, int index) {
    return showModalBottomSheet(
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
                                          height: 300,
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
                                                        top: 30),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ElevatedButton.icon(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                    .transparent),
                                                        onPressed: () {
                                                          provider
                                                              .deletePlaylist(
                                                                  index);
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
                                                          'Remove Playlist',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.white,
                                                            fontSize: 20,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
  }
}
