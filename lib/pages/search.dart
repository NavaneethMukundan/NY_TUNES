import 'package:flutter/material.dart';
import 'package:ny_tunes/pages/home_.dart';
import 'package:ny_tunes/pages/player.dart';
import 'package:ny_tunes/settings/storage.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<SongModel>> temp = ValueNotifier([]);

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
          toolbarHeight: 90,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search)),
              onChanged: (String? value) {
                if (value != null && value.isNotEmpty) {
                  temp.value.clear();
                  for (SongModel item in HomePage.songs) {
                    if (item.title
                        .toLowerCase()
                        .contains(value.toLowerCase())) {
                      temp.value.add(item);
                    }
                  }
                }
                temp.notifyListeners();
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ValueListenableBuilder(
                    valueListenable: temp,
                    builder: (BuildContext context, List<SongModel> songData,
                        Widget? child) {
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final data = songData[index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ListTile(
                                leading: QueryArtworkWidget(
                                    artworkWidth: 60,
                                    artworkBorder: BorderRadius.circular(0),
                                    artworkFit: BoxFit.cover,
                                    id: data.id,
                                    type: ArtworkType.AUDIO),
                                title: Text(
                                  data.title,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  final searchIndex = creatSearchIndex(data);
                                  FocusScope.of(context).unfocus();
                                  Storage.player.setAudioSource(
                                      Storage.createSongList(temp.value),
                                      initialIndex: searchIndex);
                                  Storage.player.play();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) =>
                                          PlayerPage(song: temp.value)));
                                },
                              ),
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return const Divider();
                          },
                          itemCount: temp.value.length);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  int? creatSearchIndex(SongModel data) {
    for (int i = 0; i < HomePage.songs.length; i++) {
      if (data.id == HomePage.songs[i].id) {
      }
      return i;
    }
    return null;
  }
}
