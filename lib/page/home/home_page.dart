import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/feature/recognizer/speech_recognizer.provider.dart';
import 'package:workout_timer/feature/workout/workout_command_usecase.provider.dart';
import 'package:workout_timer/feature/workout/workout_state.provider.dart';
import 'package:workout_timer/feature/workout/workout_state_usecase.provider.dart';
import 'package:workout_timer/framework/audio/audio_player_map.provider.dart';
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
    final recognizer = ref.watch(speechRecognizerProvider);
    final commandUseCase = ref.watch(workoutCommandUseCaseProvider);
    final workoutStateUseCase = ref.watch(workoutStateUseCaseProvider);

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

    useEffect(() {
      final subscription = recognizer.onRecognizedText().listen((event) async {
        debugPrint('[wt recognized]: $event');
        if (event.isEmpty) return;
        // e.g. event = 5分のトレーニングでインターバルは30秒間、それを4セットやりたい
        final result = await commandUseCase.analyzeCommand(event);
        if (result == null) return;
        final commands = await commandUseCase.convertCommand(result);
        debugPrint('[wt commands]: ${commands.toString()}');
        final newState = await workoutStateUseCase.execute(commands);
        if (newState == .trainingCountdown || newState == .paused || newState == .waitingForTraining) {
          final clickPlayer = ref.read(audioPlayerMap).getPlayers(.click);
          unawaited(clickPlayer?.play());
        }
      });
      return subscription.cancel;
    }, []);

    useEffect(() {
      Future<void> idle() async {
        try {
          await recognizer.idle();
        } on PlatformException catch (e) {
          debugPrint('[wt error]${e.message}');
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
