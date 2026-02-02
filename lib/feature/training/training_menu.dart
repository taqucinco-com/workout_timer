import 'package:flutter/foundation.dart';

@immutable
class TrainingMenu {
  const TrainingMenu({
    required this.trainingDuration,
    required this.intervalDuration,
    required this.rounds,
  });

  final Duration trainingDuration;
  final Duration intervalDuration;
  final int rounds;

  factory TrainingMenu.zero() => const TrainingMenu(
        trainingDuration: Duration.zero,
        intervalDuration: Duration.zero,
        rounds: 0,
      );

  TrainingMenu copyWith({
    Duration? trainingDuration,
    Duration? intervalDuration,
    int? rounds,
  }) {
    return TrainingMenu(
      trainingDuration: trainingDuration ?? this.trainingDuration,
      intervalDuration: intervalDuration ?? this.intervalDuration,
      rounds: rounds ?? this.rounds,
    );
  }
}
