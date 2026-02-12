// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/legacy.dart';
import 'package:workout_timer/feature/training/training_menu.dart';
import 'package:workout_timer/feature/training/training_menu_progress.dart';
import 'package:workout_timer/feature/training/training_usecase.dart';

class TrainingUseCaseImpl implements TrainingUseCase {
  final StateController<TrainingMenuProgress?> _progressController;

  const TrainingUseCaseImpl({required final StateController<TrainingMenuProgress?> progressController})
    : _progressController = progressController;

  @override
  Duration addDuration(Duration current, Duration plus) {
    int currentMinutes = current.inMinutes;
    int currentSeconds = current.inSeconds % 60;

    int plusMinutes = plus.inMinutes;
    int plusSeconds = plus.inSeconds % 60;

    int newSeconds = currentSeconds + plusSeconds;
    int newMinutes = currentMinutes + plusMinutes;

    if (newSeconds >= 60) {
      newSeconds = newSeconds % 60;
      // As per spec: "桁あふれによる次の桁のインクリメントを行わない"
    }

    if (newMinutes >= 100) {
      // Max 99 minutes, so 100 becomes 0
      newMinutes = 0;
      newSeconds = 0; // Also reset seconds if minutes overflow
    }

    return Duration(minutes: newMinutes, seconds: newSeconds);
  }
  
  @override
  TrainingMenuProgress? update(TrainingMenu trainingMenu) {
    final current = _progressController.state;
    if (current == null || current.lastUpdateDateTime == null) return current;

    var elapsed = DateTime.now().difference(current.lastUpdateDateTime!);
    var progress = current;

    while (elapsed > progress.remainDuration) {
      elapsed -= progress.remainDuration;
      // Transition to next state
      if (progress.isInterval) {
        progress = TrainingMenuProgress.from(
          remainDuration: trainingMenu.trainingDuration,
          isInterval: false,
          doneRounds: progress.doneRounds + 1,
        );
      } else {
        if (progress.doneRounds + 1 >= trainingMenu.rounds) {
          _progressController.state = null;
          return null;
        }
        if (trainingMenu.intervalDuration.compareTo(Duration.zero) == 0) {
          progress = TrainingMenuProgress.from(
            remainDuration: trainingMenu.trainingDuration,
            isInterval: false,
            doneRounds: progress.doneRounds + 1,
          );
        } else {
          progress = TrainingMenuProgress.from(
            remainDuration: trainingMenu.intervalDuration,
            isInterval: true,
            doneRounds: progress.doneRounds,
          );
        }
      }
    }

    final newProgress = TrainingMenuProgress.from(
      remainDuration: progress.remainDuration - elapsed,
      isInterval: progress.isInterval,
      doneRounds: progress.doneRounds,
      lastUpdateDateTime: DateTime.now(),
    );

    _progressController.state = newProgress;
    return newProgress;
  }
}
