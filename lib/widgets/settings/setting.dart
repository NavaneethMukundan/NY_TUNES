import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ny_tunes/database/Playlist_Model/playlist_model.dart';
import 'package:ny_tunes/widgets/others/splash.dart';
import 'package:ny_tunes/widgets/settings/about.dart';
import 'package:share_plus/share_plus.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

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
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_outlined,
                          size: 30,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      width: 80,
                    ),
                    const Text(
                      'Settings',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 222, 220, 220)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                TextButton.icon(
                    onPressed: () {
                      _onShareData(context);
                    },
                    icon: const Icon(
                      Icons.share,
                      color: Color.fromARGB(255, 222, 220, 220),
                      size: 30,
                    ),
                    label: const Text(
                      'Share This App',
                      style: TextStyle(
                          color: Color.fromARGB(255, 222, 220, 220),
                          fontSize: 20),
                    )),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  thickness: 1,
                ),
                // TextButton.icon(
                //     onPressed: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (ctx) => const PrivacyPolicy()));
                //     },
                //     icon: const Icon(
                //       Icons.privacy_tip_outlined,
                //       color: Color.fromARGB(255, 222, 220, 220),
                //       size: 30,
                //     ),
                //     label: const Text(
                //       'Privacy Policy',
                //       style: TextStyle(
                //           color: Color.fromARGB(255, 222, 220, 220),
                //           fontSize: 20),
                //     )),
                // const SizedBox(
                //   height: 15,
                // ),
                // const Divider(
                //   thickness: 1,
                // ),
                TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const AboutPage()));
                    },
                    icon: const Icon(
                      Icons.error,
                      color: Color.fromARGB(255, 222, 220, 220),
                      size: 30,
                    ),
                    label: const Text(
                      'About',
                      style: TextStyle(
                          color: Color.fromARGB(255, 222, 220, 220),
                          fontSize: 20),
                    )),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  thickness: 1,
                ),
                TextButton.icon(
                    onPressed: () {
                      clearDatabase(context);
                    },
                    icon: const Icon(
                      Icons.restart_alt_rounded,
                      color: Color.fromARGB(255, 222, 220, 220),
                      size: 30,
                    ),
                    label: const Text(
                      'Reset App',
                      style: TextStyle(
                          color: Color.fromARGB(255, 222, 220, 220),
                          fontSize: 20),
                    )),
                const SizedBox(
                  height: 205,
                ),
                const Divider(
                  thickness: 1,
                ),
                const Center(
                  child: Text(
                    'Version\n  1.0.0',
                    style: TextStyle(
                        color: Color.fromARGB(255, 79, 78, 78),
                        fontSize: 16,
                        letterSpacing: 2),
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }

  void _onShareData(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox;
    {
      await Share.share(
          'https://play.google.com/store/apps/details?id=com.fouvty.ny_tunes',
          subject: 'Share NY Tunes',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  void clearDatabase(context) {
    AlertDialog alert = AlertDialog(
      title: const Text("Alert !"),
      content: const Text("Would you like to Reset Yout App?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('cancel')),
        TextButton(
            onPressed: () {
              Hive.box<int>('favoriteDB').clear();
              Hive.box<MusicModel>('playlist').clear();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const SplashScreen()));
            },
            child: const Text('Continue')),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
