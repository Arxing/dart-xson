// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutputBean _$OutputBeanFromJson(Map<String, dynamic> json) {
  return OutputBean(
    data: json['data'] as List,
  );
}

Map<String, dynamic> _$OutputBeanToJson(OutputBean instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data$2ListBean _$Data$2ListBeanFromJson(Map<String, dynamic> json) {
  return Data$2ListBean(
    key2: json['key2'] as int,
    key3: json['key3'] as List,
  );
}

Map<String, dynamic> _$Data$2ListBeanToJson(Data$2ListBean instance) =>
    <String, dynamic>{
      'key2': instance.key2,
      'key3': instance.key3,
    };

Data$2ListKey3$1ListBean _$Data$2ListKey3$1ListBeanFromJson(
    Map<String, dynamic> json) {
  return Data$2ListKey3$1ListBean(
    loop: json['loop'] as bool,
    lock: json['lock'] as bool,
  );
}

Map<String, dynamic> _$Data$2ListKey3$1ListBeanToJson(
        Data$2ListKey3$1ListBean instance) =>
    <String, dynamic>{
      'loop': instance.loop,
      'lock': instance.lock,
    };

Data$1ListBean _$Data$1ListBeanFromJson(Map<String, dynamic> json) {
  return Data$1ListBean(
    key1: json['key1'] as String,
  );
}

Map<String, dynamic> _$Data$1ListBeanToJson(Data$1ListBean instance) =>
    <String, dynamic>{
      'key1': instance.key1,
    };
