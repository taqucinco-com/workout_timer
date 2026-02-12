import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/feature/platform/native_platform.provider.dart';
import 'package:workout_timer/feature/recognizer/speech_recognizer.dart';
import 'package:workout_timer/feature/recognizer/speech_recognizer.impl.dart';

final speechRecognizerProvider = Provider<SpeechRecognizer>(
  (ref) => SpeechRecognizerImpl(
    methodChannel: ref.read(methodChannelProvider),
    eventChannel: ref.read(recognizerEventChannelProvider),
  ),
);
