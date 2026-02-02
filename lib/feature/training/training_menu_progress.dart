import 'package:flutter/foundation.dart';

@immutable
class TrainingMenuProgress {
  const TrainingMenuProgress({
    required this.remainDuration,
    required this.isInterval,
    required this.doneRounds,
    required this.lastUpdateDateTime,
  });

  final Duration remainDuration;
  final bool isInterval;
  final int doneRounds;
  final DateTime? lastUpdateDateTime; // progressの直近更新時刻、バックグラウンドなどで中断に入った場合に利用

  factory TrainingMenuProgress.from({
    required final Duration remainDuration,
    final bool isInterval = false,
    required final int doneRounds,
    final DateTime? lastUpdateDateTime,
  }) => TrainingMenuProgress(
    remainDuration: remainDuration,
    isInterval: isInterval,
    doneRounds: doneRounds,
    lastUpdateDateTime: lastUpdateDateTime ?? DateTime.now(),
  );
}
