import 'package:workout_timer/feature/training/training_menu.dart';
import 'package:workout_timer/feature/training/training_menu_progress.dart';

abstract class TrainingUseCase {
  Duration addDuration(Duration current, Duration plus);

  /// Returns 
  /// - 1s後の進捗
  /// - nullが返却されるときは完了とみなす
  /// NOTE: 1s周期をコールされることを期待
  TrainingMenuProgress? updatePerSecond(TrainingMenu trainingMenu);

  TrainingMenuProgress? update(TrainingMenu trainingMenu);
}
