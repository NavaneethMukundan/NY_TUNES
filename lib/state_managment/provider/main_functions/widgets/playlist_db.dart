import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ny_tunes/database/Playlist_Model/playlist_model.dart';

class PlaylistDatabase with ChangeNotifier {
  List<MusicModel> musicListNotifier = [];

  Future<void> addPlaylist(MusicModel value) async {
    final playlistDB = Hive.box<MusicModel>('playlist');
    await playlistDB.add(value);
    getAllDetails();
    notifyListeners();
  }

  Future<void> getAllDetails() async {
    final playlistDB = Hive.box<MusicModel>('playlist');
    musicListNotifier.clear();
    musicListNotifier.addAll(playlistDB.values);
    notifyListeners();
  }

  Future<void> deletePlaylist(int index) async {
    final playlistDB = Hive.box<MusicModel>('playlist');
    await playlistDB.deleteAt(index);
    getAllDetails();
  }
}
