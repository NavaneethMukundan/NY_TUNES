import 'package:flutter/material.dart';
import 'package:ny_tunes/database/favorite_db.dart';
import 'package:ny_tunes/pages/favorite.dart';
import 'package:ny_tunes/pages/home_.dart';
import 'package:ny_tunes/pages/mini_player.dart';
import 'package:ny_tunes/pages/playlist.dart';
import 'package:ny_tunes/pages/search.dart';
import 'package:ny_tunes/storage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  void changeTab() {
    if (mounted) setState(() {});
  }

  final _pages = [
    const HomePage(),
    const SearchPage(),
    const FavoritePage(),
    const PlaylistPage(),
  ];
  final int index = 0;

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
        body: _pages[_currentIndex],
        bottomNavigationBar: ValueListenableBuilder(
            valueListenable: Favorite.favoriteSong,
            builder: (BuildContext ctx, List<SongModel> music, Widget? child) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        (Storage.player.currentIndex != null)
                            ? const MiniPlayerPage()
                            : const SizedBox(),
                      ],
                    ),
                    ResponsiveNavigationBar(
                      backgroundColor: Colors.transparent,
                      outerPadding: const EdgeInsets.all(1),
                      backgroundBlur: 1,
                      fontSize: 30,
                      borderRadius: 2,
                      activeIconColor: Colors.teal,
                      activeButtonFlexFactor: 80,
                      inactiveButtonsFlexFactor: 70,
                      selectedIndex: _currentIndex,
                      onTabChange: (int index) {
                        _currentIndex = index;
                        changeTab();
                      },
                      navigationBarButtons: const <NavigationBarButton>[
                        NavigationBarButton(
                            icon: Icons.home_outlined,
                            backgroundColor: Colors.transparent),
                        NavigationBarButton(
                            icon: Icons.search,
                            backgroundColor: Colors.transparent),
                        NavigationBarButton(
                            icon: Icons.favorite_outline_rounded,
                            backgroundColor: Colors.transparent),
                        NavigationBarButton(
                            icon: Icons.playlist_add_rounded,
                            backgroundColor: Colors.transparent),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
