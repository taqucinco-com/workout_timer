import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:workout_timer/feature/recognizer/speech_recognizer.dart';

class SpeechRecognizerImpl implements SpeechRecognizer {
  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;
  SpeechRecognizerImpl({MethodChannel? methodChannel, EventChannel? eventChannel})
    : _methodChannel = methodChannel ?? const MethodChannel('workout-timer.taqucinco.com/command'),
      _eventChannel = const EventChannel('workout-timer.taqucinco.com/recognizer');

  final BehaviorSubject<bool> _recordingSubject = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<String> _textSubject = BehaviorSubject<String>.seeded('');

  @override
  Future<void> idle() async {
    final result = await _methodChannel.invokeMethod<int>('idle');
    debugPrint('$result');
  }

  @override
  Stream<String> onRecognizedText() {
    return _eventChannel
        .receiveBroadcastStream()
        .debounceTime(const Duration(milliseconds: 750))
        .where((e) => e is String)
        .whereType()
        .map((e) {
          final previous = _textSubject.value;
          _textSubject.add(e); // 今までの全文を記録しておく
          final escapedPrevious = RegExp.escape(previous);
          return e.replaceFirst(RegExp('$escapedPrevious'), '');
        });
  }

  @override
  Future<void> start() async {
    final result = await _methodChannel.invokeMethod<int>('startRecognizer');
    _recordingSubject.add(true);
    debugPrint('$result');
  }

  @override
  Future<void> stop() async {
    final result = await _methodChannel.invokeMethod<int>('stopRecognizer');
    _recordingSubject.add(false);
    debugPrint('$result');
  }

  @override
  ValueStream<bool> onRecording() => _recordingSubject.stream;
}
