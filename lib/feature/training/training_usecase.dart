import 'package:workout_timer/feature/training/training_menu.dart';
import 'package:workout_timer/feature/training/training_menu_progress.dart';

abstract class TrainingUseCase {
  Duration addDuration(Duration current, Duration plus);

  TrainingMenuProgress? update(TrainingMenu trainingMenu);
}
