import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Storage {
  static AudioPlayer player = AudioPlayer();
  static int currentindex = -1;
  static List<SongModel> songCopy = [];
  static List<SongModel> playingSongs = [];
  static ConcatenatingAudioSource createSongList(List<SongModel> song) {
    List<AudioSource> sources = [];
    playingSongs = song;
    for (var songs in song) {
      sources.add(AudioSource.uri(Uri.parse(songs.uri!),
          tag: MediaItem(id: songs.id.toString(), title: songs.title)));
    }
    return ConcatenatingAudioSource(children: sources);
  }
}
