import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/component/duration_led.dart';
import 'package:workout_timer/feature/training/training.provider.dart';
import 'package:workout_timer/feature/workout/workout_state_usecase.provider.dart';
import 'package:workout_timer/framework/audio/audio_player_map.provider.dart';
import 'package:workout_timer/page/home/component/home_side_menu.dart';

class PausedScreen extends HookConsumerWidget {
  const PausedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateUseCase = ref.watch(workoutStateUseCaseProvider);
    final trainingMenu = ref.watch(trainingMenuProvider);
    final remainDuration = ref.watch(trainingProgressProvider.select((s) => s?.remainDuration));
    final isInterval = ref.watch(trainingProgressProvider.select((s) => s?.isInterval));
    final doneRound = ref.watch(trainingProgressProvider.select((s) => s?.doneRounds));
    final clickPlayer = ref.watch(audioPlayerMap.select((s) => s.getPlayers(.click)));

    void resume() {
      stateUseCase.resumeTraining();
      unawaited(clickPlayer?.play());
    }

    void stopTraining() {
      stateUseCase.stopTraining();
      unawaited(clickPlayer?.play());
    }

    return SizedBox.expand(
      child: Container(
        color: Colors.black,
        child: Row(
          crossAxisAlignment: .center,
          children: [
            Flexible(
              flex: 1,
              child: SizedBox.expand(
                child: HomeSideMenu(
                  durationOptions: {
                    if (isInterval == true) HomeSideMenuDurationOption.rest,
                    if (isInterval == false) HomeSideMenuDurationOption.running,
                  },
                  currentRound: (doneRound ?? 0) + 1,
                  totalRound: trainingMenu.rounds,
                  onTapStop: stopTraining,
                  onTapResume: resume,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final timerAreaSize = constraints.biggest;
                  return Stack(
                    children: [
                      SizedBox.expand(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 24),
                            if (timerAreaSize.width > 0 && timerAreaSize.height > 0)
                              DurationLed(
                                duration: remainDuration ?? trainingMenu.trainingDuration,
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
                      ),
                    ],
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
