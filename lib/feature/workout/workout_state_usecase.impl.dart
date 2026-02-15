// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/legacy.dart';
import 'package:workout_timer/feature/training/training_menu.dart';
import 'package:workout_timer/feature/training/training_menu_progress.dart';
import 'package:workout_timer/feature/workout/workout_command.dart';
import 'package:workout_timer/feature/workout/workout_state.dart';
import 'package:workout_timer/feature/workout/workout_state_usecase.dart';

class WorkoutSateUseCaseImpl implements WorkoutStateUseCase {
  final StateController<WorkoutState> _workoutStateController;
  final StateController<TrainingMenu> _pendingTrainingController;
  final StateController<TrainingMenu> _trainingController;
  final StateController<TrainingMenuProgress?> _progressController;

  const WorkoutSateUseCaseImpl({
    required final StateController<WorkoutState> workoutStateController,
    required final StateController<TrainingMenu> pendingTrainingController,
    required final StateController<TrainingMenu> trainingController,
    required final StateController<TrainingMenuProgress?> progressController,
  }) : _workoutStateController = workoutStateController,
       _pendingTrainingController = pendingTrainingController,
       _trainingController = trainingController,
       _progressController = progressController;

  @override
  Future<void> transferToProgram() async {
    _workoutStateController.state = .trainingDurationSetting;
    _pendingTrainingController.state = TrainingMenu.zero();
  }

  @override
  Future<void> transferToIntervalSet(TrainingDurationSet command) async {
    _pendingTrainingController.state = _pendingTrainingController.state.copyWith(trainingDuration: command.duration);
    _workoutStateController.state = .intervalDurationSetting;
  }

  @override
  Future<void> transferToRoundSet(IntervalDurationSet command) async {
    _pendingTrainingController.state = _pendingTrainingController.state.copyWith(intervalDuration: command.duration);
    _workoutStateController.state = .roundSetting;
  }

  @override
  Future<void> setTrainingMenu(TrainingMenuSet command) async {
    _trainingController.state = command.trainingMenu;
    _workoutStateController.state = .waitingForTraining;
  }

  @override
  Future<void> startTraining() async {
    final trainingMenu = _trainingController.state;
    if (trainingMenu.trainingDuration.compareTo(Duration.zero) > 0) {
      _progressController.state = TrainingMenuProgress.from(
        remainDuration: trainingMenu.trainingDuration,
        isInterval: false,
        doneRounds: 0,
      );
      _workoutStateController.state = .trainingCountdown;
    }
  }

  @override
  Future<void> stopTraining() async {
    _progressController.state = null;
    _workoutStateController.state = .waitingForTraining;
  }

  @override
  Future<void> pauseTraining() async {
    _workoutStateController.state = .paused;
  }

  @override
  Future<void> resumeTraining() async {
    _workoutStateController.state = .trainingCountdown;
    _progressController.state = _progressController.state?.copyWith(
      lastUpdateDateTime: DateTime.now(),
    );
  }

  @override
  Future<WorkoutState?> execute(List<WorkoutCommand> commands) async {
    final state = _workoutStateController.state;
    switch ((commands, state)) {
      case ([TrainingStart()], .waitingForTraining):
        startTraining();
        return _workoutStateController.state;
      case ([TrainingStart()], .paused):
        resumeTraining();
        return _workoutStateController.state;
      case (_, .trainingCountdown) when commands.contains(TrainingPause()):
        pauseTraining();
        return _workoutStateController.state;
      case (_, .trainingCountdown) when commands.contains(TrainingStop()):
        stopTraining();
        return _workoutStateController.state;
      case (
            final cmds,
            .timeSettingNotSet ||
                .waitingForTraining ||
                .trainingDurationSetting ||
                .intervalDurationSetting ||
                .roundSetting,
          )
          when cmds.isNotEmpty &&
              cmds.every((c) => c is TrainingDurationSet || c is IntervalDurationSet || c is RoundSet):
        {
          final menu = cmds.fold(
            _trainingController.state,
            (prev, command) => switch (command) {
              TrainingDurationSet(duration: final d) => prev.copyWith(trainingDuration: d),
              IntervalDurationSet(duration: final d) => prev.copyWith(intervalDuration: d),
              RoundSet(count: final c) => prev.copyWith(rounds: c),
              _ => prev,
            },
          );
          await setTrainingMenu(TrainingMenuSet(trainingMenu: menu));
          return _workoutStateController.state;
        }
      default:
        return null;
    }
  }
}
