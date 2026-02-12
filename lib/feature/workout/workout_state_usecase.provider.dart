import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/feature/training/training.provider.dart';
import 'package:workout_timer/feature/workout/workout_state.provider.dart';
import 'package:workout_timer/feature/workout/workout_state_usecase.dart';
import 'package:workout_timer/feature/workout/workout_state_usecase.impl.dart';

final workoutStateUseCaseProvider = Provider<WorkoutStateUseCase>((ref) {
  final workoutStateNotifier = ref.read(workoutStateProvider.notifier);
  final pendingTrainingMenuNotifier = ref.read(pendingTrainingMenuProvider.notifier);
  final trainingMenuNotifier = ref.read(trainingMenuProvider.notifier);
  final progressNotifier = ref.read(trainingProgressProvider.notifier);

  final useCase = WorkoutSateUseCaseImpl(
    workoutStateController: workoutStateNotifier,
    pendingTrainingController: pendingTrainingMenuNotifier,
    trainingController: trainingMenuNotifier,
    progressController: progressNotifier,
  );
  return useCase;
});
