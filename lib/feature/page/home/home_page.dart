import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/legacy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/feature/domain/workout_state.dart';
import 'package:workout_timer/feature/page/home/screen/time_setting_not_set_screen.dart';
import 'package:workout_timer/feature/page/home/screen/training_time_setting_screen.dart'; // New import

final workoutStateProvider = StateProvider<WorkoutState>(
  (ref) => WorkoutState.timeSettingNotSet,
);

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workoutStateProvider);

    return SafeArea(
      child: Scaffold(
        body: switch (state) {
          WorkoutState.timeSettingNotSet => const TimeSettingNotSetScreen(),
          WorkoutState.trainingTimeSetting => const TrainingTimeSettingScreen(), // New case
          _ => const Center(child: Text('Not Implemented')),
        },
      ),
    );
  }
}
