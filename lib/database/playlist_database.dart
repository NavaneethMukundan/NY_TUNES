import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ny_tunes/database/playlist_model.dart';

ValueNotifier<List<MusicModel>> musicListNotifier = ValueNotifier([]);

Future<void> addPlaylist(MusicModel value) async {
  final playlistDB = await Hive.openBox<MusicModel>('playlistDB');
  final id = await playlistDB.add(value);
  value.id = id;

  musicListNotifier.value.add(value);
  musicListNotifier.notifyListeners();
}

Future<void> getAllDetails() async {
  final playlistDB = await Hive.openBox<MusicModel>('playlistDB');
  musicListNotifier.value.clear();

  musicListNotifier.value.addAll(playlistDB.values);
  musicListNotifier.notifyListeners();
}

Future<void> deletePlaylist(int index) async {
  final playlistDB = await Hive.openBox<MusicModel>('playlistDB');
  await playlistDB.deleteAt(index);
  getAllDetails();
}
