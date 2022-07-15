import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ny_tunes/database/playlist_model.dart';

ValueNotifier<List<MusicModel>> musicListNotifier = ValueNotifier([]);

Future<void> addPlaylist(MusicModel value) async {
  final playlistDB = Hive.box<MusicModel>('playlist');
  await playlistDB.add(value);
  // value.id = id;

  // musicListNotifier.value.add(value);
  // musicListNotifier.notifyListeners();
}

Future<void> getAllDetails() async {
  final playlistDB = Hive.box<MusicModel>('playlist');
  musicListNotifier.value.clear();

  musicListNotifier.value.addAll(playlistDB.values);
  musicListNotifier.notifyListeners();
}

Future<void> deletePlaylist(int index) async {
  final playlistDB = Hive.box<MusicModel>('playlist');
  await playlistDB.deleteAt(index);
  getAllDetails();
}
