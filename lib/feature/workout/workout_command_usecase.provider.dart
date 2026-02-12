import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/feature/platform/native_platform.provider.dart';
import 'package:workout_timer/feature/workout/workout_command_usecase.dart';
import 'package:workout_timer/feature/workout/workout_command_usecase.impl.dart';

final workoutCommandUseCaseProvider = Provider<WorkoutCommandUseCase>(
  (ref) => WorkoutCommandUsecaseImpl(ref.read(methodChannelProvider)),
);
