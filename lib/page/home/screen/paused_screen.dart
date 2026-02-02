import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/component/duration_led.dart';
import 'package:workout_timer/feature/training/training.provider.dart';
import 'package:workout_timer/feature/workout/workout_state_usecase.provider.dart';
import 'package:workout_timer/framework/build_context_ext.dart';
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

    final timerAreaKey = useMemoized(() => GlobalKey(), []);
    final timerAreaSize = useState(Size(0, 0));

    void calcSize() {
      final tuple = timerAreaKey.currentContext?.boundingRect();
      if (tuple != null) {
        final (_, size) = tuple;
        timerAreaSize.value = size;
      }
    }

    void resume() {
      stateUseCase.resumeTraining();
    }

    void stopTraining() {
      stateUseCase.stopTraining();
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
                  durationOption: (isInterval ?? true) ? .rest : .running,
                  currentRound: (doneRound ?? 0) + 1,
                  totalRound: trainingMenu.rounds,
                  onTapStop: stopTraining,
                  onTapResume: resume,
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
                  child: Stack(
                    children: [
                      SizedBox.expand(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 24),
                            if (timerAreaSize.value.width > 0 && timerAreaSize.value.height > 0)
                              DurationLed(
                                duration: remainDuration ?? trainingMenu.trainingDuration,
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
                      ),
                    ],
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
