// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutputBean _$OutputBeanFromJson(Map<String, dynamic> json) {
  return OutputBean(
    list: (json['list'] as List)
        ?.map((e) => e == null ? null : OutputList$0ListBean.fromJson(e))
        ?.toList(),
  );
}

Map<String, dynamic> _$OutputBeanToJson(OutputBean instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

OutputList$0ListBean _$OutputList$0ListBeanFromJson(Map<String, dynamic> json) {
  return OutputList$0ListBean(
    a: _parserFuncList$0ListA(json['a']),
    b: _parserFuncList$0ListB(json['b']),
  );
}

Map<String, dynamic> _$OutputList$0ListBeanToJson(
        OutputList$0ListBean instance) =>
    <String, dynamic>{
      'a': instance.a,
      'b': instance.b,
    };
