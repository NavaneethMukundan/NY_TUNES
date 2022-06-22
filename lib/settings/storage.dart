import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Storage{
  static AudioPlayer player = AudioPlayer();
  static int currentindex = -1;
  static ConcatenatingAudioSource createSongList(List<SongModel>song){
    List<AudioSource> sources = [];
    for (var songs in song){
      sources.add(AudioSource.uri(Uri.parse(songs.uri!)));
    }
    return ConcatenatingAudioSource(children: sources);
  }

  
 
}
