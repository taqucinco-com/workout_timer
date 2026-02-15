import 'package:flutter_test/flutter_test.dart';
import 'package:workout_timer/feature/workout/workout_command.dart';
import 'package:workout_timer/feature/workout/workout_command_usecase.impl.dart';

void main() {
  group('convertCommand', () {
    final usecase = WorkoutCommandUsecaseImpl();
    test('should return a list of WorkoutCommands for a valid JSON with multiple commands', () async {
      const jsonString = '''
        [
            {
                "command": "set-timer",
                "parameter": "00:03:00"
            },
            {
                "command": "set-round",
                "parameter": "3"
            }
        ]
        ''';

      final commands = await usecase.convertCommand(jsonString);

      expect(commands.length, 2);
      expect(commands[0], isA<TrainingDurationSet>());
      expect((commands[0] as TrainingDurationSet).duration, const Duration(minutes: 3));
      expect(commands[1], isA<RoundSet>());
      expect((commands[1] as RoundSet).count, 3);
    });

    test('should return a list with a single command for a JSON with one command and no parameter', () async {
      const jsonString = '''
        [
            {
                "command": "start-command"
            }
        ]
        ''';

      final commands = await usecase.convertCommand(jsonString);

      expect(commands.length, 1);
      expect(commands[0], isA<TrainingStart>());
    });

    test('should ignore commands with invalid parameters', () async {
      const jsonString = '''
        [
            {
                "command": "set-timer",
                "parameter": "invalid-duration"
            },
            {
                "command": "set-round",
                "parameter": "not-a-number"
            }
        ]
        ''';

      final commands = await usecase.convertCommand(jsonString);

      expect(commands.isEmpty, isTrue);
    });

    test('should return an empty list for an empty JSON array', () async {
      const jsonString = '[]';
      final commands = await usecase.convertCommand(jsonString);
      expect(commands.isEmpty, isTrue);
    });

    test('should ignore "nothing" command', () async {
      const jsonString = '''
        [
            {
                "command": "nothing"
            },
            {
                "command": "set-timer",
                "parameter": "00:01:00"
            }
        ]
        ''';

      final commands = await usecase.convertCommand(jsonString);

      expect(commands.length, 1);
      expect(commands[0], isA<TrainingDurationSet>());
    });

    test('should handle set-interval command correctly', () async {
      const jsonString = '''
        [
            {
                "command": "set-interval",
                "parameter": "00:01:30"
            }
        ]
        ''';

      final commands = await usecase.convertCommand(jsonString);
      expect(commands.length, 1);
      expect(commands[0], isA<IntervalDurationSet>());
      expect((commands[0] as IntervalDurationSet).duration, const Duration(minutes: 1, seconds: 30));
    });
  });
}
