import 'package:flutter/material.dart';
import 'package:ny_tunes/settings/about.dart';
import 'package:ny_tunes/settings/privacy_policy.dart';
import 'package:share_plus/share_plus.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
        body: SafeArea(
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
              TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const PrivacyPolicy()));
                  },
                  icon: const Icon(
                    Icons.privacy_tip_outlined,
                    color: Color.fromARGB(255, 222, 220, 220),
                    size: 30,
                  ),
                  label: const Text(
                    'Privacy Policy',
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const AboutPage()));
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
                  onPressed: () {},
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
                height: 305,
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
    );
  }

  void _onShareData(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox;
    {
      await Share.share('PlayStore Link will Be Avilable Soon ',
          subject: 'Share NY Tunes',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }
}
