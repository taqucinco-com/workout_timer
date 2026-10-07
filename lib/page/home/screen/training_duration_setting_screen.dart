import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/component/duration_led.dart';
import 'package:workout_timer/feature/training/training.provider.dart';
import 'package:workout_timer/feature/training/training_usecase.provider.dart';
import 'package:workout_timer/feature/workout/workout_command.dart';
import 'package:workout_timer/feature/workout/workout_state_usecase.provider.dart';
import 'package:workout_timer/page/home/component/duration_buttons.dart';
import 'package:workout_timer/page/home/component/home_side_menu.dart';

class TrainingDurationSettingScreen extends HookConsumerWidget {
  const TrainingDurationSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingUseCase = ref.watch(trainingUseCaseProvider);
    final workoutStateUsecase = ref.watch(workoutStateUseCaseProvider);

    final pendingDuration = useState(ref.read(pendingTrainingMenuProvider.select((s) => s.trainingDuration)));

    void onTapDurationPlus(Duration duration) {
      final newDuration = trainingUseCase.addDuration(pendingDuration.value, duration);
      pendingDuration.value = newDuration;
    }

    void toNext() {
      workoutStateUsecase.transferToIntervalSet(TrainingDurationSet(pendingDuration.value));
    }

    void clearTimer() {
      pendingDuration.value = Duration.zero;
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
                  durationOptions: {.running},
                  onTapSet: pendingDuration.value == Duration.zero ? null : toNext,
                  onTapReset: clearTimer,
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
                                duration: pendingDuration.value,
                                blinking: true,
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
                      Positioned(
                        bottom: 16,
                        left: 0,
                        right: 0,
                        child: Row(
                          children: [
                            const Spacer(),
                            DurationButtons(onDurationChanged: onTapDurationPlus),
                            const Spacer(),
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
