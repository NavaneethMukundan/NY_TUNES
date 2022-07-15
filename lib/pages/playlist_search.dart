import 'package:flutter/material.dart';
import 'package:ny_tunes/database/playlist_database.dart';
import 'package:ny_tunes/database/playlist_model.dart';
import 'package:ny_tunes/pages/playlist_songs.dart';

ValueNotifier<List<MusicModel>> temp = ValueNotifier([]);

class PlaylistSearchPage extends StatefulWidget {
  const PlaylistSearchPage({
    Key? key,
  }) : super(key: key);
  // final MusicModel musicModel;
  @override
  State<PlaylistSearchPage> createState() => _PlaylistSearchPageState();
}

class _PlaylistSearchPageState extends State<PlaylistSearchPage> {
  @override
  Widget build(BuildContext context) {
    getAllDetails();
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 150,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 30,
              )),
          title: SizedBox(
            height: 50,
            child: TextField(
              // cursorHeight: 25,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Search from Playlist',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  fillColor: Colors.white,
                  filled: true),
              onChanged: (String? value) {
                if (value != null && value.isNotEmpty) {
                  temp.value.clear();
                  for (MusicModel item in musicListNotifier.value) {
                    if (item.name.toLowerCase().contains(value.toLowerCase())) {
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
                    builder: (BuildContext context,
                        List<MusicModel> playlistData, Widget? child) {
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final data = playlistData[index];
                            return ListTile(
                              tileColor: const Color.fromARGB(255, 0, 32, 29),
                              leading: Image.asset(
                                'Assets/images/defaultPlaylistImage-removebg-preview.png',
                                color: Colors.white,
                              ),
                              title: Text(
                                data.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (ctx) => PlaylistData(
                                              folderindex: index,
                                              playlist: data,
                                            )));
                              },
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return const Divider(
                              thickness: 1,
                            );
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
}
