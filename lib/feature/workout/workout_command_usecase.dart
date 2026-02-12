import 'package:workout_timer/feature/workout/workout_command.dart';

abstract class WorkoutCommandUseCase {
  /// Returns: PlatformException
  Future<String?> analyzeCommand(String text);

  Future<List<WorkoutCommand>> convertCommand(String json);
}
