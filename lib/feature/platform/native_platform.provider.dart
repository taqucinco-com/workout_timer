
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final methodChannelProvider = Provider((_) => const MethodChannel('workout-timer.taqucinco.com/command'));
final recognizerEventChannelProvider = Provider((_) => const EventChannel('workout-timer.taqucinco.com/recognizer'));
