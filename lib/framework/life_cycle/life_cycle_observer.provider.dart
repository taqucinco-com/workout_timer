import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/framework/life_cycle/life_cycle_listener.provider.dart';

final lifeCycleObserverProvider = StreamProvider<AppLifecycleState>((ref) {
  final listener = ref.watch(lifeCycleListenerProvider); // implではなくlistenerをwatch
  // ref.onDispose(impl.dispose); はlifeCycleListenerProviderで処理されるため不要
  return listener.stateStream;
});
