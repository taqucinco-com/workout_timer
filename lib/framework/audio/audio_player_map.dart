import 'package:audioplayers/audioplayers.dart';

enum AudioSource { alarm, gong }

abstract class AudioPlayerMap {
  AudioPlayer? getPlayers(AudioSource as);
}
