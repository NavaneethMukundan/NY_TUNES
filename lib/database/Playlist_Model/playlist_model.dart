import 'package:hive_flutter/adapters.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 1)
class MusicModel extends HiveObject {
  // int? id;

  @HiveField(0)
  String name;

  @HiveField(1)
  List<int> songData;

  MusicModel({required this.name, required this.songData});

  add(int id) async {
    songData.add(id);
    save();
  }

  deleteData(int id) {
    songData.remove(id);
    save();
  }

  bool isValueIn(int id) {
    return songData.contains(id);
  }
}
