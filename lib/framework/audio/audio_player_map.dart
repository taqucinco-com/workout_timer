
import 'package:just_audio/just_audio.dart';

enum AudioSource { alarm, gong }

abstract class AudioPlayerMap {
  AudioPlayer? getPlayers(AudioSource as);
}
