import 'package:workout_timer/feature/workout/workout_command.dart';
import 'package:workout_timer/feature/workout/workout_state.dart';

abstract class WorkoutStateUseCase {
  Future<void> transferToProgram();
  Future<void> transferToIntervalSet(TrainingDurationSet command);
  Future<void> transferToRoundSet(IntervalDurationSet command);
  Future<void> setTrainingMenu(TrainingMenuSet command);
  Future<void> startTraining();
  Future<void> stopTraining();
  Future<void> pauseTraining();
  Future<void> resumeTraining();
  Future<WorkoutState?> execute(List<WorkoutCommand> commands);
}
