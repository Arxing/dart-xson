// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutputBean _$OutputBeanFromJson(Map<String, dynamic> json) {
  return OutputBean(
    res: _parserFuncRes(json['res']),
    id: _parserFuncId(json['id']),
    username: _parserFuncUsername(json['username']),
    pass: _parserFuncPass(json['pass']),
    award: _parserFuncAward(json['award']),
    amoney: _parserFuncAmoney(json['amoney']),
    bmoney: _parserFuncBmoney(json['bmoney']),
    money: _parserFuncMoney(json['money']),
    gift: _parserFuncGift(json['gift']),
    rebate: _parserFuncRebate(json['rebate']),
    bcmoney: _parserFuncBcmoney(json['bcmoney']),
    blmoney: _parserFuncBlmoney(json['blmoney']),
    type: _parserFuncType(json['type']),
    isb: _parserFuncIsb(json['isb']),
    isz: _parserFuncIsz(json['isz']),
    lv: _parserFuncLv(json['lv']),
    rkey: _parserFuncRkey(json['rkey']),
    realname: _parserFuncRealname(json['realname']),
    icon: _parserFuncIcon(json['icon']),
    phone: _parserFuncPhone(json['phone']),
  );
}

Map<String, dynamic> _$OutputBeanToJson(OutputBean instance) =>
    <String, dynamic>{
      'res': instance.res,
      'id': instance.id,
      'username': instance.username,
      'pass': instance.pass,
      'award': instance.award,
      'amoney': instance.amoney,
      'bmoney': instance.bmoney,
      'money': instance.money,
      'gift': instance.gift,
      'rebate': instance.rebate,
      'bcmoney': instance.bcmoney,
      'blmoney': instance.blmoney,
      'type': instance.type,
      'isb': instance.isb,
      'isz': instance.isz,
      'lv': instance.lv,
      'rkey': instance.rkey,
      'realname': instance.realname,
      'icon': instance.icon,
      'phone': instance.phone,
    };
