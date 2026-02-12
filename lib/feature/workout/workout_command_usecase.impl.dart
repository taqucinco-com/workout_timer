import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:workout_timer/feature/workout/command_analyzer_schema.dart';
import 'package:workout_timer/feature/workout/workout_command.dart';
import 'package:workout_timer/feature/workout/workout_command_usecase.dart';

class WorkoutCommandUsecaseImpl implements WorkoutCommandUseCase {
  final MethodChannel _methodChannel;
  WorkoutCommandUsecaseImpl([MethodChannel? methodChannel])
    : _methodChannel = methodChannel ?? const MethodChannel('workout-timer.taqucinco.com/command');

  
  @override
  Future<String?> analyzeCommand(String text) async {
    return await _methodChannel.invokeMethod<String>('analyzeCommand', '5分のトレーニングでインターバルは30秒間、それを4セットやりたい');
  }

  @override
  Future<List<WorkoutCommand>> convertCommand(String json) async {
    final List<dynamic> jsonList = jsonDecode(json);
    final schemas = jsonList.map((e) => CommandAnalyzerSchema.fromJson(e as Map<String, dynamic>)).toList();
  

    final List<WorkoutCommand> commands = [];
    for (final schema in schemas) {
      switch (schema.command) {
        case 'set-timer':
          if (schema.parameter != null) {
            final parts = schema.parameter!.split(':');
            if (parts.length == 3) {
              final hours = int.tryParse(parts[0]) ?? 0;
              final minutes = int.tryParse(parts[1]) ?? 0;
              final seconds = int.tryParse(parts[2]) ?? 0;
              commands.add(TrainingDurationSet(Duration(hours: hours, minutes: minutes, seconds: seconds)));
            }
          }
          break;
        case 'set-interval':
          if (schema.parameter != null) {
            final parts = schema.parameter!.split(':');
            if (parts.length == 3) {
              final hours = int.tryParse(parts[0]) ?? 0;
              final minutes = int.tryParse(parts[1]) ?? 0;
              final seconds = int.tryParse(parts[2]) ?? 0;
              commands.add(IntervalDurationSet(Duration(hours: hours, minutes: minutes, seconds: seconds)));
            }
          }
          break;
        case 'set-round':
          if (schema.parameter != null) {
            final count = int.tryParse(schema.parameter!);
            if (count != null) {
              commands.add(RoundSet(count));
            }
          }
          break;
        case 'start-command':
          commands.add(const TrainingStart());
          break;
        // 'nothing' やその他のコマンドは無視
      }
    }
    return commands;
  }
}
