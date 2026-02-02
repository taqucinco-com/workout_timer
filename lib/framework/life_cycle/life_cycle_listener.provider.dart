import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/framework/life_cycle/life_cycle_listener.dart';
import 'package:workout_timer/framework/life_cycle/life_cycle_listener.impl.dart';

final lifeCycleListenerProvider = Provider<LifeCycleListener>((ref) {
  final impl = LifeCycleListenerImpl();
  ref.onDispose(impl.dispose);
  return impl;
});
