import 'package:flutter/foundation.dart';

@immutable
sealed class WorkoutCommand {
  const WorkoutCommand();
}

/// Command to set the training duration.
class TrainingDurationSet extends WorkoutCommand {
  final Duration duration;
  TrainingDurationSet(this.duration)
      : assert(
            duration.inSeconds >= 0 && duration.inMinutes <= 99, 'Training duration must be between 0 and 99 minutes.');
}

/// Command to set the interval duration.
class IntervalDurationSet extends WorkoutCommand {
  final Duration duration;
  IntervalDurationSet(this.duration)
      : assert(
            duration.inSeconds >= 0 && duration.inMinutes <= 99, 'Interval duration must be between 0 and 99 minutes.');
}

/// Command to set the number of rounds/sets.
class RoundSet extends WorkoutCommand {
  final int count;
  const RoundSet(this.count) : assert(count > 0 && count <= 99, 'Round count must be between 1 and 99.');
}

/// Command to set all training parameters at once.
class TrainingSet extends WorkoutCommand {
  final Duration trainingDuration;
  final Duration intervalDuration;
  final int roundCount;

  const TrainingSet({
    required this.trainingDuration,
    required this.intervalDuration,
    required this.roundCount,
  });
}

/// Command to start the training countdown.
class TrainingStart extends WorkoutCommand {
  const TrainingStart();
}

/// Command to pause the active countdown.
class TrainingPause extends WorkoutCommand {
  const TrainingPause();
}

/// Command to stop the active countdown and reset to the waiting state.
class TrainingStop extends WorkoutCommand {
  const TrainingStop();
}

/// Command to resume a paused countdown.
class TrainingResume extends WorkoutCommand {
  const TrainingResume();
}
