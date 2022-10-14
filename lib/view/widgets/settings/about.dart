import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

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
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
              child: Column(
                children: [
                  const Center(
                      child: Text(
                    'About',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Image.asset('Assets/images/NY tunes Logo.png'),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'A music player Application by Navaneeth Mukundan .Its a finished disconnected music player, that you can hear tunes without web. By this Application you can encounter the music in the style as like a web-based music player shows',
                    style: TextStyle(
                        height: 1.5,
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
