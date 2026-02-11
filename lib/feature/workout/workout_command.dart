import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:workout_timer/feature/training/training_menu.dart';
import 'package:workout_timer/feature/workout/command_analyzer_schema.dart';

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
}

/// Command to set the interval duration.
class IntervalDurationSet extends WorkoutCommand {
  final Duration duration;
  IntervalDurationSet(this.duration)
      : assert(
          duration.inSeconds >= 0 && duration.inMinutes <= 99,
          'Interval duration must be between 0 and 99 minutes.',
        );
}

/// Command to set the number of rounds/sets.
class RoundSet extends WorkoutCommand {
  final int count;
  const RoundSet(this.count)
      : assert(count > 0 && count <= 99, 'Round count must be between 1 and 99.');
}

/// Command to set all training parameters at once.
class TrainingMenuSet extends WorkoutCommand {
  final TrainingMenu trainingMenu;

  const TrainingMenuSet({required this.trainingMenu});
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

List<WorkoutCommand> convertCommand(String json) {
  final List<dynamic> jsonList = jsonDecode(json);
  final schemas = jsonList
      .map((e) => CommandAnalyzerSchema.fromJson(e as Map<String, dynamic>))
      .toList();

  final List<WorkoutCommand> commands = [];
  for (final schema in schemas) {
    switch (schema.command) {
      case 'set-timer':
        if (schema.parameter != null) {
          final parts = schema.parameter!.split(':');
          if (parts.length == 3) {
            final hours = int.tryParse(parts[0]) ?? 0;
            final minutes = int.tryParse(parts[1]) ?? 0;
            final seconds = int.tryParse(parts[2]) ?? 0;
            commands.add(TrainingDurationSet(
                Duration(hours: hours, minutes: minutes, seconds: seconds)));
          }
        }
        break;
      case 'set-interval':
        if (schema.parameter != null) {
          final parts = schema.parameter!.split(':');
          if (parts.length == 3) {
            final hours = int.tryParse(parts[0]) ?? 0;
            final minutes = int.tryParse(parts[1]) ?? 0;
            final seconds = int.tryParse(parts[2]) ?? 0;
            commands.add(IntervalDurationSet(
                Duration(hours: hours, minutes: minutes, seconds: seconds)));
          }
        }
        break;
      case 'set-round':
        if (schema.parameter != null) {
          final count = int.tryParse(schema.parameter!);
          if (count != null) {
            commands.add(RoundSet(count));
          }
        }
        break;
      case 'start-command':
        commands.add(const TrainingStart());
        break;
      // 'nothing' やその他のコマンドは無視
    }
  }
  return commands;
}