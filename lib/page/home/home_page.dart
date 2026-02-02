import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/feature/workout/workout_state.provider.dart';
import 'package:workout_timer/page/home/screen/countdown_screen.dart';
import 'package:workout_timer/page/home/screen/interval_time_setting_screen.dart';
import 'package:workout_timer/page/home/screen/paused_screen.dart';
import 'package:workout_timer/page/home/screen/round_count_setting_screen.dart';
import 'package:workout_timer/page/home/screen/training_duration_setting_screen.dart';
import 'package:workout_timer/page/home/screen/waiting_for_training_screen.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workoutStateProvider);

    return SafeArea(
      child: Scaffold(
        body: switch (state) {
          .timeSettingNotSet => const WaitingForTrainingScreen(duration: Duration.zero, totalRound: 1),
          .trainingDurationSetting => const TrainingDurationSettingScreen(),
          .intervalDurationSetting => const IntervalTimeSettingScreen(),
          .roundSetting => const RoundCountSettingScreen(),
          .waitingForTraining => const WaitingForTrainingScreen(),
          .trainingCountdown => CountdownScreen(),
          .paused => PausedScreen(),
        },
      ),
    );
  }
}