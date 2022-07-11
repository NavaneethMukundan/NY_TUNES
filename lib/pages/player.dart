import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ny_tunes/database/favorite_btn.dart';
import 'package:ny_tunes/database/playlist_database.dart';
import 'package:ny_tunes/settings/storage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key, required this.playersong}) : super(key: key);
  final List<SongModel> playersong;

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  void initState() {
    Storage.player.currentIndexStream.listen((index) {});
    super.initState();
  }

  final int index = Storage.currentindex;

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SafeArea(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                          musicListNotifier.notifyListeners();
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 30,
                          color: Colors.white,
                        )),
                    const Text(
                      'Playing form your Library',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert_outlined,
                          size: 28,
                          color: Colors.white,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: QueryArtworkWidget(
                      artworkBorder: BorderRadius.circular(1),
                      artworkWidth: 100,
                      artworkHeight: 400,
                      id: widget.playersong[Storage.player.currentIndex!].id,
                      type: ArtworkType.AUDIO,
                    )),
                const SizedBox(
                  height: 120,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.playersong[Storage.player.currentIndex!]
                              .displayNameWOExt,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                            "${widget.playersong[Storage.player.currentIndex!].artist}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            )),
                      ],
                    ),
                    FavorBtn(
                      song: widget.playersong[Storage.player.currentIndex!],
                    ),
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: (Favorite.isfavor(
                    //             widget.song[Storage.player.currentIndex!])
                    //         ? Icon(
                    //             Icons.favorite,
                    //             color: Colors.white,
                    //           )
                    //         : Icon(
                    //             Icons.favorite_border,
                    //             color: Colors.amber,
                    //           )))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder<DurationState>(
                    stream: _durationStateStream,
                    builder: (context, snapshot) {
                      final duractionState = snapshot.data;
                      final progress =
                          duractionState?.position ?? Duration.zero;
                      final total = duractionState?.total ?? Duration.zero;

                      return ProgressBar(
                          progress: progress,
                          total: total,
                          barHeight: 3.0,
                          thumbRadius: 5,
                          progressBarColor: Colors.white,
                          thumbColor: Colors.white,
                          baseBarColor: Colors.grey,
                          bufferedBarColor: Colors.grey,
                          buffered: const Duration(milliseconds: 2000),
                          onSeek: (duration) {
                            Storage.player.seek(duration);
                          });
                    }),
                StreamBuilder<DurationState>(
                    stream: _durationStateStream,
                    builder: (context, snapshot) {
                      final duractionState = snapshot.data;
                      final progress =
                          duractionState?.position ?? Duration.zero;
                      final total = duractionState?.total ?? Duration.zero;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                              child: Text(
                            progress.toString().split(".")[0],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          )),
                          Flexible(
                              child: Text(
                            total.toString().split(".")[0],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ))
                        ],
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(15),
                            primary: Colors.black,
                            onPrimary: Colors.white),
                        onPressed: () {
                          Storage.player.setShuffleModeEnabled(true);

                          //ScaffoldMessenger(child: SnackBar(content: Text('Shuffle Enacled')));
                        },
                        child: StreamBuilder<bool>(
                            //    stream: Storage.player.shuffleModeEnabledStream,
                            builder: (context, snapshot) {
                          bool? shuffleState = snapshot.data;
                          if (shuffleState != null && shuffleState) {
                            return const Icon(
                              Icons.shuffle,
                              color: Colors.teal,
                              size: 25,
                            );
                          } else {
                            return const Icon(
                              Icons.shuffle,
                              size: 25,
                            );
                          }
                        }),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(15),
                              primary: Colors.black,
                              onPrimary: Colors.white),
                          onPressed: () async {
                            if (Storage.player.hasPrevious) {
                              await Storage.player.seekToPrevious();
                              setState(() {});
                            } else {
                              Storage.player.play();
                              setState(() {});
                            }
                          },
                          child: const Icon(Icons.skip_previous_rounded,
                              color: Colors.white, size: 45)),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(15),
                            primary: Colors.black,
                            onPrimary: Colors.white),
                        onPressed: () async {
                          if (Storage.player.playing) {
                            await Storage.player.pause();
                            setState(() {});
                          } else {
                            if (Storage.player.currentIndex != null) {
                              await Storage.player.play();
                            }
                            setState(() {});
                          }
                        },
                        child: StreamBuilder<bool>(
                            stream: Storage.player.playingStream,
                            builder: (context, snapshot) {
                              bool? playingState = snapshot.data;
                              if (playingState != null && playingState) {
                                return const Icon(
                                  Icons.pause_circle_filled,
                                  size: 55,
                                );
                              } else {
                                return const Icon(
                                  Icons.play_circle_fill_rounded,
                                  size: 55,
                                );
                              }
                            }),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(15),
                              primary: Colors.black,
                              onPrimary: Colors.white),
                          onPressed: () async {
                            if (Storage.player.hasNext) {
                              await Storage.player.seekToNext();
                              setState(() {});
                            } else {
                              Storage.currentindex = 0;
                              await Storage.player.play();
                              setState(() {});
                            }
                          },
                          child: const Icon(Icons.skip_next_rounded,
                              color: Colors.white, size: 45)),
                    ),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(15),
                              primary: Colors.black,
                              onPrimary: Colors.white),
                          onPressed: () {
                            Storage.player.loopMode == LoopMode.one
                                ? Storage.player.setLoopMode(LoopMode.all)
                                : Storage.player.setLoopMode(LoopMode.one);
                          },
                          child: StreamBuilder<LoopMode>(
                            stream: Storage.player.loopModeStream,
                            builder: (context, snapshot) {
                              final loopMode = snapshot.data;
                              if (LoopMode.one == loopMode) {
                                return const Icon(
                                  Icons.repeat_one,
                                  color: Colors.teal,
                                  size: 25,
                                );
                              } else {
                                return const Icon(
                                  Icons.repeat,
                                  size: 30,
                                );
                              }
                            },
                          )),
                    ),
                  ],
                )
              ],
            )),
          ),
        ),
      ),
    );
  }

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          Storage.player.positionStream,
          Storage.player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
