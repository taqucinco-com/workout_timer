import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/component/seven_segment_number.dart';
import 'package:workout_timer/feature/training/training.provider.dart';
import 'package:workout_timer/feature/training/training_menu.dart';
import 'package:workout_timer/feature/workout/workout_command.dart';
import 'package:workout_timer/feature/workout/workout_state_usecase.provider.dart';
import 'package:workout_timer/framework/build_context_ext.dart';
import 'package:workout_timer/page/home/component/home_side_menu.dart';

class RoundCountSettingScreen extends HookConsumerWidget {
  const RoundCountSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutStateUsecase = ref.watch(workoutStateUseCaseProvider);

    final timerAreaKey = useMemoized(() => GlobalKey(), []);
    final timerAreaSize = useState(Size(0, 0));
    final pendingRounds = useState(1);

    void calcSize() {
      final tuple = timerAreaKey.currentContext?.boundingRect();
      if (tuple != null) {
        final (_, size) = tuple;
        timerAreaSize.value = size;
      }
    }

    void toNext() {
      final pended = ref.read(pendingTrainingMenuProvider);
      workoutStateUsecase.setTrainingMenu(
        TrainingMenuSet(
          trainingMenu: TrainingMenu(
            trainingDuration: pended.trainingDuration,
            intervalDuration: pended.intervalDuration,
            rounds: pendingRounds.value,
          ),
        ),
      );
    }

    void clearTimer() {
      workoutStateUsecase.transferToProgram();
    }

    void incrementRounds() {
      if (pendingRounds.value < 99) {
        pendingRounds.value++;
      }
    }

    void decrementRounds() {
      if (pendingRounds.value > 1) {
        pendingRounds.value--;
      }
    }

    final roundString = pendingRounds.value.toString().padLeft(2, '0');

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
                  durationOption: null, // No duration option for round setting
                  onTapSet: toNext,
                  onTapReset: clearTimer,
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
                              _BlinkingRoundCount(
                                roundString: roundString,
                                color: Colors.orange.shade700,
                                segmentSize: Size(
                                  min(96.0, timerAreaSize.value.width * 0.2),
                                  min(164.0, timerAreaSize.value.height * 0.8),
                                ),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: decrementRounds,
                              child: Text('-1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton(
                              onPressed: incrementRounds,
                              child: Text('+1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
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

class _BlinkingRoundCount extends HookWidget {
  const _BlinkingRoundCount({
    required this.roundString,
    required this.color,
    required this.segmentSize,
  });

  final String roundString;
  final Color color;
  final Size segmentSize;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 750),
    );

    useEffect(() {
      animationController.repeat(reverse: true);
      return null;
    }, []);

    final animatedColor = useAnimation(
      ColorTween(
        begin: color,
        end: color.withAlpha((256 / 10).toInt()),
      ).animate(animationController),
    );

    return Row(
      children: [
        SevenSegmentNumber(
          digit: roundString[0],
          color: animatedColor ?? color,
          segmentSize: segmentSize,
        ),
        SizedBox(width: 16.0),
        SevenSegmentNumber(
          digit: roundString[1],
          color: animatedColor ?? color,
          segmentSize: segmentSize,
        ),
      ],
    );
  }
}
