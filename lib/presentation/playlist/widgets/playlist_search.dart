import 'package:flutter/material.dart';
import 'package:ny_tunes/presentation/playlist/widgets/playlist_songs.dart';
import 'package:ny_tunes/state_managment/provider/main_functions/main_functions.dart';
import 'package:ny_tunes/state_managment/provider/main_functions/widgets/playlist_db.dart';
import 'package:provider/provider.dart';

class PlaylistSearchPage extends StatelessWidget {
  const PlaylistSearchPage({
    Key? key,
  }) : super(key: key);
  // final MusicModel musicModel;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaylistDatabase>(context, listen: false);
    final provider2 =
        Provider.of<PlaylistFunctionController>(context, listen: false);
    provider.getAllDetails();
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
                provider2.searchFilter(value);
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Consumer<PlaylistDatabase>(
                    builder: (context, playlistData, child) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final data = playlistData.musicListNotifier[index];
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
                      itemCount: provider2.musicListNotifier.length);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
