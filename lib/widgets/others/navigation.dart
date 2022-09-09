import 'package:flutter/material.dart';
import 'package:ny_tunes/presentation/favorite/favorite.dart';
import 'package:ny_tunes/presentation/Home/home_.dart';
import 'package:ny_tunes/presentation/widgets/mini_player.dart';
import 'package:ny_tunes/presentation/playlist/playlist.dart';
import 'package:ny_tunes/presentation/search/search.dart';
import 'package:ny_tunes/state_managment/provider/main_functions/widgets/favorite_db_functions.dart';
import 'package:ny_tunes/state_managment/provider/state_navigation.dart';
import 'package:ny_tunes/widgets/others/storage.dart';
import 'package:provider/provider.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

class NavigationPage extends StatelessWidget {
  NavigationPage({Key? key}) : super(key: key);

  final _pages = [
    HomePage(),
    const SearchPage(),
    const FavoritePage(),
    const PlaylistPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationFunctionControl>(context);
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
        body: _pages[provider.currentIndex],
        bottomNavigationBar: Consumer<FavoriteFunctionController>(
            builder: (context, value, child) {
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
                  selectedIndex: provider.currentIndex,
                  onTabChange: (newindex) {
                    provider.currentIndex = newindex;
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
