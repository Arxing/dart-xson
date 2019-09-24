// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutputBean _$OutputBeanFromJson(Map<String, dynamic> json) {
  return OutputBean(
    a1: json['a1'] == null ? null : OutputA1Bean.fromJson(json['a1']),
    $100: json['100'] == null ? null : Output$100Bean.fromJson(json['100']),
  );
}

Map<String, dynamic> _$OutputBeanToJson(OutputBean instance) =>
    <String, dynamic>{
      'a1': instance.a1,
      '100': instance.$100,
    };

Output$100Bean _$Output$100BeanFromJson(Map<String, dynamic> json) {
  return Output$100Bean(
    aa2: json['aa2'] == null ? null : Output$100Aa2Bean.fromJson(json['aa2']),
  );
}

Map<String, dynamic> _$Output$100BeanToJson(Output$100Bean instance) =>
    <String, dynamic>{
      'aa2': instance.aa2,
    };

Output$100Aa2Bean _$Output$100Aa2BeanFromJson(Map<String, dynamic> json) {
  return Output$100Aa2Bean(
    aaa2: (json['aaa2'] as List)
        ?.map((e) => e == null ? null : Output$100Aa2Aaa2$0ListBean.fromJson(e))
        ?.toList(),
  );
}

Map<String, dynamic> _$Output$100Aa2BeanToJson(Output$100Aa2Bean instance) =>
    <String, dynamic>{
      'aaa2': instance.aaa2,
    };

Output$100Aa2Aaa2$0ListBean _$Output$100Aa2Aaa2$0ListBeanFromJson(
    Map<String, dynamic> json) {
  return Output$100Aa2Aaa2$0ListBean(
    aaaa2: json['aaaa2'] == null
        ? null
        : Output$100Aa2Aaa2$0ListAaaa2Bean.fromJson(json['aaaa2']),
  );
}

Map<String, dynamic> _$Output$100Aa2Aaa2$0ListBeanToJson(
        Output$100Aa2Aaa2$0ListBean instance) =>
    <String, dynamic>{
      'aaaa2': instance.aaaa2,
    };

Output$100Aa2Aaa2$0ListAaaa2Bean _$Output$100Aa2Aaa2$0ListAaaa2BeanFromJson(
    Map<String, dynamic> json) {
  return Output$100Aa2Aaa2$0ListAaaa2Bean();
}

Map<String, dynamic> _$Output$100Aa2Aaa2$0ListAaaa2BeanToJson(
        Output$100Aa2Aaa2$0ListAaaa2Bean instance) =>
    <String, dynamic>{};

OutputA1Bean _$OutputA1BeanFromJson(Map<String, dynamic> json) {
  return OutputA1Bean(
    aa1: (json['aa1'] as List)
        ?.map((e) => e == null ? null : OutputA1Aa1$0ListBean.fromJson(e))
        ?.toList(),
  );
}

Map<String, dynamic> _$OutputA1BeanToJson(OutputA1Bean instance) =>
    <String, dynamic>{
      'aa1': instance.aa1,
    };

OutputA1Aa1$0ListBean _$OutputA1Aa1$0ListBeanFromJson(
    Map<String, dynamic> json) {
  return OutputA1Aa1$0ListBean();
}

Map<String, dynamic> _$OutputA1Aa1$0ListBeanToJson(
        OutputA1Aa1$0ListBean instance) =>
    <String, dynamic>{};
