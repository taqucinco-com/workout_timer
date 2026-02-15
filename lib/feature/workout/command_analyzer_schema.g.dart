// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command_analyzer_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommandAnalyzerSchema _$CommandAnalyzerSchemaFromJson(
  Map<String, dynamic> json,
) => _CommandAnalyzerSchema(
  command: json['command'] as String? ?? '',
  parameter: json['parameter'] as String?,
);

Map<String, dynamic> _$CommandAnalyzerSchemaToJson(
  _CommandAnalyzerSchema instance,
) => <String, dynamic>{
  'command': instance.command,
  'parameter': instance.parameter,
};
