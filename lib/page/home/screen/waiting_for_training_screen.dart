import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/component/duration_led.dart';
import 'package:workout_timer/feature/training/training.provider.dart';
import 'package:workout_timer/feature/workout/workout_state_usecase.provider.dart';
import 'package:workout_timer/framework/audio/audio_player_map.provider.dart';
import 'package:workout_timer/page/home/component/home_side_menu.dart';

class WaitingForTrainingScreen extends HookConsumerWidget {
  final Duration? duration;
  final int? totalRound;
  const WaitingForTrainingScreen({super.key, this.duration, this.totalRound});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useCase = ref.watch(workoutStateUseCaseProvider);
    final trainingDuration = duration ?? ref.watch(trainingMenuProvider.select((s) => s.trainingDuration));
    final intervalDuration =
        duration ?? ref.watch(trainingMenuProvider.select((s) => s.intervalDuration)) ?? Duration.zero;
    final clickPlayer = ref.watch(audioPlayerMap.select((s) => s.getPlayers(.click)));
    final trainingTotalRound = totalRound ?? ref.watch(trainingMenuProvider.select((s) => s.rounds)) ?? 1;

    void transferProgram() {
      useCase.transferToProgram();
    }

    void startTraining() {
      useCase.startTraining();
      unawaited(clickPlayer?.play());
    }

    return SizedBox.expand(
      child: Container(
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: SizedBox.expand(
                child: HomeSideMenu(
                  onTapProgram: transferProgram,
                  durationOptions: {.running, if (intervalDuration > Duration.zero) .rest},
                  currentRound: 1,
                  onTapStart: startTraining,
                  totalRound: trainingTotalRound,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final timerAreaSize = constraints.biggest;
                  return SizedBox.expand(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 24),
                            if (timerAreaSize.width > 0 && timerAreaSize.height > 0)
                              DurationLed(
                                duration: trainingDuration ?? Duration(),
                                color: Colors.orange.shade700,
                                segmentSize: Size(
                                  min(96.0, timerAreaSize.width * 0.2),
                                  min(164.0, timerAreaSize.height * 0.8),
                                ),
                                colonSize: Size(12, min(96.0, timerAreaSize.height * 0.8)),
                                margin: 16.0,
                              ),
                            SizedBox(width: 24),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
