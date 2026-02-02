import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/framework/audio/audio_player_map.dart';
import 'package:workout_timer/framework/audio/audio_player_map.impl.dart';

final audioPlayerMap = Provider<AudioPlayerMap>((re) => AudioPlayerMapImpl());
