// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RootBean _$RootBeanFromJson(Map<String, dynamic> json) {
  return RootBean(
    apple: json['apple'] == null
        ? null
        : AppleBean.fromJson(json['apple'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RootBeanToJson(RootBean instance) => <String, dynamic>{
      'apple': instance.apple,
    };

AppleBean _$AppleBeanFromJson(Map<String, dynamic> json) {
  return AppleBean(
    banana: json['banana'] == null
        ? null
        : AppleBananaBean.fromJson(json['banana'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppleBeanToJson(AppleBean instance) => <String, dynamic>{
      'banana': instance.banana,
    };

AppleBananaBean _$AppleBananaBeanFromJson(Map<String, dynamic> json) {
  return AppleBananaBean(
    food:
        (json['food'] as List)?.map((e) => e as Map<String, dynamic>)?.toList(),
  );
}

Map<String, dynamic> _$AppleBananaBeanToJson(AppleBananaBean instance) =>
    <String, dynamic>{
      'food': instance.food,
    };

AppleBananaFood$0ListBean _$AppleBananaFood$0ListBeanFromJson(
    Map<String, dynamic> json) {
  return AppleBananaFood$0ListBean(
    jo: (json['jo'] as List)?.map((e) => e as List)?.toList(),
  );
}

Map<String, dynamic> _$AppleBananaFood$0ListBeanToJson(
        AppleBananaFood$0ListBean instance) =>
    <String, dynamic>{
      'jo': instance.jo,
    };
