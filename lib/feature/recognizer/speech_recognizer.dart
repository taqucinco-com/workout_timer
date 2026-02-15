import 'package:rxdart/rxdart.dart';

abstract class SpeechRecognizer {
  Future<void> idle();
  Future<void> start();
  Future<void> stop();
  Stream<String> onRecognizedText();
  ValueStream<bool> onRecording();
}
