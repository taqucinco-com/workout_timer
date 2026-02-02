import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:workout_timer/framework/audio/audio_player_map.dart';

class AudioPlayerMapImpl implements AudioPlayerMap {
  final Map<AudioSource, AudioPlayer> _players = {AudioSource.alarm: AudioPlayer(), AudioSource.gong: AudioPlayer()};

  AudioPlayerMapImpl() {
    unawaited(_initialize());
  }

  Future<void> _initialize() async {
    await _players[AudioSource.alarm]?.setSource(AssetSource('sounds/alarm.mp3'));
    await _players[AudioSource.alarm]?.setReleaseMode(ReleaseMode.stop);
    await _players[AudioSource.gong]?.setSource(AssetSource('sounds/gong.mp3'));
    await _players[AudioSource.gong]?.setReleaseMode(ReleaseMode.stop);
  }

  @override
  AudioPlayer? getPlayers(AudioSource as) {
    return _players[as];
  }
}
