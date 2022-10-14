// Favorite Screen functions.
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoriteFunctionController with ChangeNotifier {
  List<SongModel> favoriteSongs = [];
  bool isInitialized = false;
  final musicDB = Hive.box<int>('favoriteDB');
  bool isfavor(SongModel song) {
    if (musicDB.values.contains(song.id)) {
      return true;
    }
    return false;
  }

  initialise(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (isfavor(song)) {
        favoriteSongs.add(song);
      }
    }
    isInitialized = true;
  }

  add(SongModel song) async {
    musicDB.add(song.id);
    favoriteSongs.add(song);
  }

  delete(int id) {
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
    favoriteSongs.removeWhere((song) => song.id == id);
  }

  void refresh() {
    notifyListeners();
  }
}
