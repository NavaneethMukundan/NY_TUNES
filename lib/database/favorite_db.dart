import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Favorite {
  static bool isInitialized = false;
  static final musicDB = Hive.box<int>('favoriteDB');
  static ValueNotifier<List<SongModel>> favoriteSong = ValueNotifier([]);
  static initialise(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (isfavor(song)) {
        favoriteSong.value.add(song);
      }
    }
    isInitialized = true;
  }

  static add(SongModel song) async {
    musicDB.add(song.id);
    favoriteSong.value.add(song);
  }

  static delete(int id) {
    int deletekey = 0;
    if (!musicDB.values.contains(id)) {
      return;
    }

    final Map<dynamic, int> favorMap = musicDB.toMap();

    favorMap.forEach((key, value) {
      if (value == id) {
        deletekey = key;
      }
    });
    musicDB.delete(deletekey);
    favoriteSong.value.removeWhere((song) => song.id == id);
  }

  static bool isfavor(SongModel song) {
    if (musicDB.values.contains(song.id)) {
      return true;
    }
    return false;
  }
}
