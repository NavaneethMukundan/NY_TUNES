import 'package:flutter/material.dart';
import 'package:ny_tunes/pages/player.dart';
import 'package:ny_tunes/settings/setting.dart';
import 'package:ny_tunes/settings/storage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

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
    super.initState();
    requstPermission();
  }

  // @override
  // void dispose() {
  //   Storage.player.dispose();
  //   super.dispose();
  // }

  void requstPermission() {
    Permission.storage.request();
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
                          Icons.person_outlined,
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
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (ctx, index) {
                          return ListTile(
                            onTap: () {
                              Storage.player.setAudioSource(
                                  Storage.createSongList(item.data!),
                                  initialIndex: index);
                              if (Storage.currentindex != index) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) =>
                                        PlayerPage(song: item.data!)));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        PlayerPage(song: item.data!)));
                              }
                            },
                            iconColor: Colors.white,
                            textColor: Colors.white,
                            leading: QueryArtworkWidget(
                                id: item.data![index].id,
                                type: ArtworkType.AUDIO),
                            title: Text(item.data![index].displayNameWOExt),
                            subtitle: Text("${item.data![index].artist}"),
                            trailing: const Icon(Icons.more_vert_rounded),
                          );
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider();
                        },
                        itemCount: item.data!.length);
                  },
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
