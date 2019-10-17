// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutputBean _$OutputBeanFromJson(Map<String, dynamic> json) {
  return OutputBean(
      res: _parserFuncRes(json['res']),
      data: _parserFuncData(json['data']),
      m: _parserFuncM(json['m']));
}

Map<String, dynamic> _$OutputBeanToJson(OutputBean instance) =>
    <String, dynamic>{
      'res': instance.res,
      'data': instance.data,
      'm': instance.m
    };

OutputData$0ListBean _$OutputData$0ListBeanFromJson(Map<String, dynamic> json) {
  return OutputData$0ListBean(
      type: _parserFuncData$0ListType(json['type']),
      team: _parserFuncData$0ListTeam(json['team']),
      b: _parserFuncData$0ListB(json['b']),
      reward: _parserFuncData$0ListReward(json['reward']),
      mold: _parserFuncData$0ListMold(json['mold']));
}

Map<String, dynamic> _$OutputData$0ListBeanToJson(
        OutputData$0ListBean instance) =>
    <String, dynamic>{
      'type': instance.type,
      'team': instance.team,
      'b': instance.b,
      'reward': instance.reward,
      'mold': instance.mold
    };
