import 'package:flutter/foundation.dart';
import 'package:workout_timer/feature/training/training_menu.dart';

@immutable
sealed class WorkoutCommand {
  const WorkoutCommand();
}

/// Command to set the training duration.
class TrainingDurationSet extends WorkoutCommand {
  final Duration duration;
  TrainingDurationSet(this.duration)
      : assert(
          duration.inSeconds >= 0 && duration.inMinutes <= 99,
          'Training duration must be between 0 and 99 minutes.',
        );

  @override
  String toString() => 'TrainingDurationSet(duration: $duration)';
}

/// Command to set the interval duration.
class IntervalDurationSet extends WorkoutCommand {
  final Duration duration;
  IntervalDurationSet(this.duration)
      : assert(
          duration.inSeconds >= 0 && duration.inMinutes <= 99,
          'Interval duration must be between 0 and 99 minutes.',
        );

  @override
  String toString() => 'IntervalDurationSet(duration: $duration)';
}

/// Command to set the number of rounds/sets.
class RoundSet extends WorkoutCommand {
  final int count;
  const RoundSet(this.count)
      : assert(count > 0 && count <= 99, 'Round count must be between 1 and 99.');

  @override
  String toString() => 'RoundSet(count: $count)';
}

/// Command to set all training parameters at once.
class TrainingMenuSet extends WorkoutCommand {
  final TrainingMenu trainingMenu;

  const TrainingMenuSet({required this.trainingMenu});

  @override
  String toString() => 'TrainingMenuSet(trainingMenu: ${trainingMenu.toString()})';
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
