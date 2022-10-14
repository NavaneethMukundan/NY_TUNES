import 'package:flutter/material.dart';
import 'package:ny_tunes/view/Home/home_.dart';
import 'package:ny_tunes/view/widgets/player.dart';
import 'package:ny_tunes/controller/provider/main_functions/main_functions.dart';
import 'package:ny_tunes/view/widgets/others/storage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<SearchFunctionController>(context, listen: false);
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
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: 90,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search)),
              onChanged: (String? value) {
                provider.searchFilter(value);
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Consumer<SearchFunctionController>(
                    builder: (context, songData, child) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final data = songData.temp[index];
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
                                  Storage.createSongList(HomePage.songs),
                                  initialIndex: searchIndex);
                              Storage.player.play();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) =>
                                      PlayerPage(playersong: HomePage.songs)));
                            },
                          ),
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return const Divider();
                      },
                      itemCount: provider.temp.length);
                }),
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
        return i;
      }
    }
    return null;
  }
}
