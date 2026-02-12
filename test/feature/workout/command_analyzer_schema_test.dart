import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:workout_timer/feature/workout/command_analyzer_schema.dart';

void main() {
  group('CommandAnalyzerSchema', () {
    test('fromJson should correctly parse JSON with multiple commands', () {
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

      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      final List<CommandAnalyzerSchema> schemas =
          jsonList.map((e) => CommandAnalyzerSchema.fromJson(e as Map<String, dynamic>)).toList();

      expect(schemas.length, 2);

      expect(schemas[0].command, 'set-timer');
      expect(schemas[0].parameter, '00:03:00');

      expect(schemas[1].command, 'set-round');
      expect(schemas[1].parameter, '3');
    });

    test('toJson should correctly convert to JSON', () {
      const schema = CommandAnalyzerSchema(command: 'set-timer', parameter: '00:03:00');
      final json = schema.toJson();

      expect(json['command'], 'set-timer');
      expect(json['parameter'], '00:03:00');
    });
  });
}