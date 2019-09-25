import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:xson/src/json_value_transformer.dart';
part 'output.g.dart';

@JsonSerializable()
class OutputBean {
  bool _rootIsList = false;
  @JsonKey(fromJson: _parserFuncRes)
  int res;
  @JsonKey(fromJson: _parserFuncId)
  String id;
  @JsonKey(fromJson: _parserFuncUsername)
  String username;
  @JsonKey(fromJson: _parserFuncPass)
  String pass;
  @JsonKey(fromJson: _parserFuncAward)
  String award;
  @JsonKey(fromJson: _parserFuncAmoney)
  String amoney;
  @JsonKey(fromJson: _parserFuncBmoney)
  String bmoney;
  @JsonKey(fromJson: _parserFuncMoney)
  String money;
  @JsonKey(fromJson: _parserFuncGift)
  String gift;
  @JsonKey(fromJson: _parserFuncRebate)
  String rebate;
  @JsonKey(fromJson: _parserFuncBcmoney)
  String bcmoney;
  @JsonKey(fromJson: _parserFuncBlmoney)
  String blmoney;
  @JsonKey(fromJson: _parserFuncType)
  String type;
  @JsonKey(fromJson: _parserFuncIsb)
  int isb;
  @JsonKey(fromJson: _parserFuncIsz)
  int isz;
  @JsonKey(fromJson: _parserFuncLv)
  int lv;
  @JsonKey(fromJson: _parserFuncRkey)
  int rkey;
  @JsonKey(fromJson: _parserFuncRealname)
  String realname;
  @JsonKey(fromJson: _parserFuncIcon)
  int icon;
  @JsonKey(fromJson: _parserFuncPhone)
  int phone;

  OutputBean(
      {this.res,
      this.id,
      this.username,
      this.pass,
      this.award,
      this.amoney,
      this.bmoney,
      this.money,
      this.gift,
      this.rebate,
      this.bcmoney,
      this.blmoney,
      this.type,
      this.isb,
      this.isz,
      this.lv,
      this.rkey,
      this.realname,
      this.icon,
      this.phone});
  factory OutputBean.fromJson(dynamic json) {
    if (json is Map) return _$OutputBeanFromJson(json);
    if (json is List) return _$OutputBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

int _parserFuncRes(dynamic v) => JsonValueTransformer.parse<int>(v);

String _parserFuncId(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncUsername(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncPass(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncAward(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncAmoney(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncBmoney(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncMoney(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncGift(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncRebate(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncBcmoney(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncBlmoney(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncType(dynamic v) => JsonValueTransformer.parse<String>(v);

int _parserFuncIsb(dynamic v) => JsonValueTransformer.parse<int>(v);

int _parserFuncIsz(dynamic v) => JsonValueTransformer.parse<int>(v);

int _parserFuncLv(dynamic v) => JsonValueTransformer.parse<int>(v);

int _parserFuncRkey(dynamic v) => JsonValueTransformer.parse<int>(v);

String _parserFuncRealname(dynamic v) => JsonValueTransformer.parse<String>(v);

int _parserFuncIcon(dynamic v) => JsonValueTransformer.parse<int>(v);

int _parserFuncPhone(dynamic v) => JsonValueTransformer.parse<int>(v);
