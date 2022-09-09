import 'package:flutter/material.dart';
import 'package:ny_tunes/database/Favorite_Button/favorite_btn.dart';
import 'package:ny_tunes/presentation/widgets/player.dart';
import 'package:ny_tunes/state_managment/provider/main_functions/widgets/favorite_db_functions.dart';
import 'package:ny_tunes/widgets/others/storage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<FavoriteFunctionController>(context, listen: false);
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
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Liked Songs',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: provider.favoriteSongs.isEmpty
                        ? const Center(
                            child: Text(
                              'No Song Found',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )
                        : Consumer<FavoriteFunctionController>(
                            builder: (context, value, child) {
                              return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (ctx, index) {
                                    return ListTile(
                                        onTap: () {
                                          List<SongModel> newlist = [
                                            ...value.favoriteSongs
                                          ];
                                          provider.notifyListeners();
                                          Storage.player.stop();
                                          Storage.player.setAudioSource(
                                              Storage.createSongList(newlist),
                                              initialIndex: index);
                                          //Storage.player.play();
                                          Storage.currentindex = index;
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) => PlayerPage(
                                                      playersong: newlist)));
                                        },
                                        leading: QueryArtworkWidget(
                                          id: value.favoriteSongs[index].id,
                                          type: ArtworkType.AUDIO,
                                          errorBuilder:
                                              (context, excepion, gdb) {
                                            return Image.asset('');
                                          },
                                        ),
                                        title: Text(
                                          value.favoriteSongs[index].title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        subtitle: Text(
                                          value.favoriteSongs[index].artist!,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        trailing: FavorBtn(
                                            song: value.favoriteSongs[index]));
                                  },
                                  separatorBuilder: (ctx, index) {
                                    return const Divider();
                                  },
                                  itemCount: value.favoriteSongs.length);
                            },
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
