import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/feature/training/training.provider.dart';
import 'package:workout_timer/feature/training/training_usecase.dart';
import 'package:workout_timer/feature/training/training_usecase.impl.dart';

final trainingUseCaseProvider = Provider<TrainingUseCase>(
  (ref) => TrainingUseCaseImpl(
    progressController: ref.read(trainingProgressProvider.notifier),
  ),
);
