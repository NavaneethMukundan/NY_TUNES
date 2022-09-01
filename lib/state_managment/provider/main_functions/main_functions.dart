import 'package:flutter/material.dart';
import 'package:ny_tunes/database/Playlist_Model/playlist_model.dart';
import 'package:ny_tunes/presentation/Home/home_.dart';
import 'package:ny_tunes/state_managment/provider/main_functions/widgets/playlist_db.dart';
import 'package:ny_tunes/widgets/others/storage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

// Home screen functions.
class HomeFunctionController with ChangeNotifier {
  void requestFunction() async {
    await Permission.storage.request();
    notifyListeners();
  }

  List<SongModel> song = [];
}

// Search Screen Functions.
class SearchFunctionController with ChangeNotifier {
  searchFilter(value) {
    if (value != null && value.isNotEmpty) {
      temp.clear();
      for (SongModel item in HomePage.songs) {
        if (item.title.toLowerCase().contains(value.toLowerCase())) {
          temp.add(item);
        }
      }
    }
    notifyListeners();
  }

  List<SongModel> temp = [];
}

// PlayList screen Functions
class PlaylistFunctionController with ChangeNotifier {
  final nameController = TextEditingController();

  whenButtonClicked(context) async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      return;
    } else {
      final music = MusicModel(name: name, songData: []);
      Provider.of<PlaylistDatabase>(context, listen: false).addPlaylist(music);
    }
    notifyListeners();
    Navigator.of(context).pop();
  }

  searchFilter(value) {
    if (value != null && value.isNotEmpty) {
      temp.clear();
      for (MusicModel item in musicListNotifier) {
        if (item.name.toLowerCase().contains(value.toLowerCase())) {
          temp.add(item);
        }
      }
    }
    notifyListeners();
  }

  List<MusicModel> temp = [];
  List<MusicModel> musicListNotifier = [];
}

// Mini Player Screen Function
class MiniPlayer with ChangeNotifier {
  miniPlayer() {
    Storage.player.currentIndexStream.listen((index) {
      if (index != null) {
        notifyListeners();
      }
    });
  }
}

class PlayerFunctionController with ChangeNotifier {
  int currentIndex = 0;
  playerData() {
    Storage.player.currentIndexStream.listen((index) {
      if (index != null) {
        notifyListeners();
        currentIndex = index;
        Storage.currentindex = index;
      }
      notifyListeners();
    });
  }
}
