import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/component/duration_led.dart';
import 'package:workout_timer/feature/training/training.provider.dart';
import 'package:workout_timer/feature/workout/workout_state_usecase.provider.dart';
import 'package:workout_timer/framework/build_context_ext.dart'; // Import DurationLed
import 'package:workout_timer/page/home/component/home_side_menu.dart';

class WaitingForTrainingScreen extends HookConsumerWidget {
  final Duration? duration;
  final int? totalRound;
  const WaitingForTrainingScreen({super.key, this.duration, this.totalRound});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useCase = ref.watch(workoutStateUseCaseProvider);
    final trainingDuration = duration ?? ref.watch(trainingMenuProvider.select((s) => s.trainingDuration));
    final trainingTotalRound = totalRound ?? ref.watch(trainingMenuProvider.select((s) => s.rounds)) ?? 1;

    final timerAreaKey = useMemoized(() => GlobalKey(), []);
    final timerAreaSize = useState(Size(0, 0));

    void calcSize() {
      final tuple = timerAreaKey.currentContext?.boundingRect();
      if (tuple != null) {
        final (_, size) = tuple;
        timerAreaSize.value = size;
      }
    }

    void transferProgram() {
      useCase.transferToProgram();
    }

    void startTraining() {
      useCase.startTraining();
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
                  durationOption: .running,
                  currentRound: 1,
                  onTapStart: startTraining,
                  totalRound: trainingTotalRound,
                ),
              ),
            ),
            Builder(
              builder: (context) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    calcSize();
                  }
                });
                return Flexible(
                  key: timerAreaKey,
                  flex: 3,
                  child: SizedBox.expand(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 24),
                            if (timerAreaSize.value.width > 0 && timerAreaSize.value.height > 0)
                              DurationLed(
                                duration: trainingDuration ?? Duration(),
                                color: Colors.orange.shade700,
                                segmentSize: Size(
                                  min(96.0, timerAreaSize.value.width * 0.2),
                                  min(164.0, timerAreaSize.value.height * 0.8),
                                ),
                                colonSize: Size(12, min(96.0, timerAreaSize.value.height * 0.8)),
                                margin: 16.0,
                              ),
                            SizedBox(width: 24),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
