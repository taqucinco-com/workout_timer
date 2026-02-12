import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/feature/recognizer/speech_recognizer.provider.dart';
import 'package:workout_timer/feature/workout/workout_command_usecase.provider.dart';
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
    final commandUseCase = ref.watch(workoutCommandUseCaseProvider);
    final recognizer = ref.watch(speechRecognizerProvider);

    final recording = useStream(recognizer.onRecording());
    final animationController = useAnimationController(duration: const Duration(milliseconds: 1000));

    useEffect(() {
      if (recording.data ?? false) {
        animationController.repeat(reverse: true);
      } else {
        animationController.stop();
      }
      return null;
    }, [recording.data]);

    final animatedColor = useAnimation(
      ColorTween(begin: Colors.blue.shade400, end: Colors.blue.shade100).animate(animationController),
    );

    // Future<void> runChannel() async {
    //   try {
    //     final result = await useCase.analyzeCommand('5分のトレーニングでインターバルは30秒間、それを4セットやりたい');
    //     if (result == null) return;
    //     final commands = await useCase.convertCommand(result);
    //     debugPrint('$commands');
    //   } on PlatformException catch (e) {
    //     debugPrint("${e.message}");
    //   }
    // }

    useEffect(() {
      final subscription = recognizer.onRecognizedText().listen((event) {
        debugPrint('$event');
      });
      return subscription.cancel;
    }, []);

    useEffect(() {
      Future<void> idle() async {
        try {
          await recognizer.idle();
        } on PlatformException catch (e) {
          debugPrint("${e.message}");
        }
      }

      unawaited(idle());
      return null;
    }, []);

    Future<void> tapMicIcon() async {
      try {
        if (recording.data ?? false) {
          await recognizer.stop();
        } else {
          await recognizer.start();
        }
      } on PlatformException catch (e) {
        debugPrint("${e.message}");
      }
    }

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
        floatingActionButton: IconButton(
          onPressed: tapMicIcon,
          icon: Icon(Icons.mic, color: recording.data ?? false ? animatedColor : Colors.grey, size: 60),
        ),
      ),
    );
  }
}
