import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

  static const platform = MethodChannel('workout-timer.taqucinco.com/command');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workoutStateProvider);

    Future<void> getBatteryLevel() async {
      try {
        final result = await platform.invokeMethod<String>('analyzeCommand', '5分のトレーニングでインターバルは30秒間、それを4セットやりたい');
        debugPrint('$result');
      } on PlatformException catch (e) {
        debugPrint("${e.message}");
      }
    }

    useEffect(() {
      unawaited(getBatteryLevel());
      return null;
    }, []);

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
