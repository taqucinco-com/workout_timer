import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:workout_timer/framework/audio/audio_player_map.dart' as apm;

class AudioPlayerMapImpl implements apm.AudioPlayerMap {
  final Map<apm.AudioSource, AudioPlayer> _players = {
    apm.AudioSource.alarm: AudioPlayer(),
    apm.AudioSource.gong: AudioPlayer(),
  };

  late final StreamSubscription<PlaybackEvent>? _alarmSubscription;
  late final StreamSubscription<PlaybackEvent>? _gongSubscription;

  AudioPlayerMapImpl() {
    unawaited(_initialize());
  }

  Future<void> _initialize() async {
    try {
      await _players[apm.AudioSource.alarm]?.setAsset('assets/sounds/alarm.mp3');
      await _players[apm.AudioSource.gong]?.setAsset('assets/sounds/gong.mp3');

      _alarmSubscription = _players[apm.AudioSource.alarm]?.playbackEventStream.listen((event) async {
        if (event.processingState == .completed) {
          await Future.delayed(Duration(milliseconds: (1028 * 1000 / 44100).toInt()));
          _players[apm.AudioSource.alarm]?.stop();
          _players[apm.AudioSource.alarm]?.seek(Duration.zero);
        }
      });
      _gongSubscription = _players[apm.AudioSource.gong]?.playbackEventStream.listen((event) async {
        if (event.processingState == .completed) {
          await Future.delayed(Duration(milliseconds: (1028 * 1000 / 44100).toInt()));
          _players[apm.AudioSource.gong]?.stop();
          _players[apm.AudioSource.gong]?.seek(Duration.zero);
        }
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  void dispose() {
    _alarmSubscription?.cancel();
    _gongSubscription?.cancel();

  }

  @override
  AudioPlayer? getPlayers(apm.AudioSource as) {
    return _players[as];
  }
}
