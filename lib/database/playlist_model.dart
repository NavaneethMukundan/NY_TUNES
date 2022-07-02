import 'package:hive_flutter/adapters.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 1)
class MusicModel extends HiveObject {
  int? id;

  @HiveField(0)
  String name;

  MusicModel({required this.name, this.id});
}
