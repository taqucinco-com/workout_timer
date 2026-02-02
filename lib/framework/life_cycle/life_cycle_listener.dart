import 'dart:ui';

abstract interface class LifeCycleListener {
  Stream<AppLifecycleState> get stateStream;
  void dispose();
}
