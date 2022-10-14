import 'package:flutter/material.dart';
import 'package:ny_tunes/controller/provider/main_functions/widgets/playlist_db.dart';
import 'package:ny_tunes/model/Playlist_Model/playlist_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SongListPage extends StatelessWidget {
  SongListPage({Key? key, required this.playlist}) : super(key: key);

  final MusicModel playlist;

  final audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaylistDatabase>(context);
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
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Center(
                          child: Text(
                            'Add Songs ',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 190,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 30,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
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
                          return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (ctx, index) {
                                return ListTile(
                                  onTap: () {},
                                  iconColor: Colors.white,
                                  textColor: Colors.white,
                                  leading: QueryArtworkWidget(
                                      id: item.data![index].id,
                                      type: ArtworkType.AUDIO),
                                  title:
                                      Text(item.data![index].displayNameWOExt),
                                  subtitle: Text("${item.data![index].artist}"),
                                  trailing: IconButton(
                                      onPressed: () {
                                        playlistCheck(
                                            item.data![index], context);
                                        provider.notifyListeners();
                                        //musicListNotifier.notifyListeners();
                                      },
                                      icon: const Icon(Icons.add)),
                                );
                              },
                              separatorBuilder: (ctx, index) {
                                return const Divider();
                              },
                              itemCount: item.data!.length);
                        })
                  ]),
                ),
              ),
            )));
  }

  void playlistCheck(SongModel data, context) {
    if (!playlist.isValueIn(data.id)) {
      playlist.add(data.id);
      const snackbar = SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            'Added to Playlist',
            style: TextStyle(color: Colors.white),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
