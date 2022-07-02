import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Playlist {
  static bool isInitialized = false;
  static ValueNotifier<List<SongModel>> playlistFolder = ValueNotifier([]);
  static final songDB = Hive.box<int>('playlistDatabase');
  static List<String> folderName = [];
  static initialise(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (isplaylist(song)) {
        playlistFolder.value.add(song);
      }
    }
    isInitialized = true;
  }

  static add(SongModel song) async {
    songDB.add(song.id);
    playlistFolder.value.add(song);
  }

  static delete(int id) {
    int deletekey = 0;
    if (!songDB.values.contains(id)) {
      return;
    }

    final Map<dynamic, int> favorMap = songDB.toMap();

    favorMap.forEach((key, value) {
      if (value == id) {
        deletekey = key;
      }
    });
    songDB.delete(deletekey);
    playlistFolder.value.removeWhere((song) => song.id == id);
  }

  static bool isplaylist(SongModel song) {
    if (songDB.values.contains(song.id)) {
      return true;
    }
    return false;
  }
}
