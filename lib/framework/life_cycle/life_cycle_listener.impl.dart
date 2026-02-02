import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workout_timer/framework/life_cycle/life_cycle_listener.dart';

class LifeCycleListenerImpl implements LifeCycleListener {
  final streamController = StreamController<AppLifecycleState>.broadcast();
  late final AppLifecycleListener _appLifecycleListener;

  LifeCycleListenerImpl() {
    _appLifecycleListener = AppLifecycleListener(
      onStateChange: (state) => streamController.sink.add(state),
    );
  }

  @override
  Stream<AppLifecycleState> get stateStream => streamController.stream;

  @override
  void dispose() {
    _appLifecycleListener.dispose();
    streamController.close();
  }
}
