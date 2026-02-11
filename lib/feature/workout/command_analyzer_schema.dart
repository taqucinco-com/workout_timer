import 'package:freezed_annotation/freezed_annotation.dart';

part 'command_analyzer_schema.freezed.dart';
part 'command_analyzer_schema.g.dart';

@freezed
abstract class CommandAnalyzerSchema with _$CommandAnalyzerSchema {
  const factory CommandAnalyzerSchema({@Default('') String command, String? parameter}) = _CommandAnalyzerSchema;

  factory CommandAnalyzerSchema.fromJson(Map<String, dynamic> json) => _$CommandAnalyzerSchemaFromJson(json);
}
