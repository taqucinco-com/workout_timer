// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/legacy.dart';
import 'package:workout_timer/feature/workout/workout_state.dart';

final workoutStateProvider = StateProvider<WorkoutState>(
  (_) => WorkoutState.timeSettingNotSet,
);
