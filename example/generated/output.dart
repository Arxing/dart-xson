import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:xson_utils/xson_utils.dart';
part 'output.g.dart';

@JsonSerializable()
class OutputBean {
  bool _rootIsList = false;
  @JsonKey(fromJson: _parserFuncRes)
  int res;
  @JsonKey(fromJson: _parserFuncData)
  List<OutputData$0ListBean> data;
  @JsonKey(fromJson: _parserFuncM)
  int m;

  OutputBean({this.res, this.data, this.m});
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

@JsonSerializable()
class OutputData$0ListBean {
  bool _rootIsList = false;
  @JsonKey(fromJson: _parserFuncData$0ListType)
  int type;
  @JsonKey(fromJson: _parserFuncData$0ListTeam)
  List<List<dynamic>> team;
  @JsonKey(fromJson: _parserFuncData$0ListB)
  int b;
  @JsonKey(fromJson: _parserFuncData$0ListReward)
  double reward;
  @JsonKey(fromJson: _parserFuncData$0ListMold)
  int mold;

  OutputData$0ListBean({this.type, this.team, this.b, this.reward, this.mold});
  factory OutputData$0ListBean.fromJson(dynamic json) {
    if (json is Map) return _$OutputData$0ListBeanFromJson(json);
    if (json is List) return _$OutputData$0ListBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputData$0ListBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

dynamic _innerValueParser<R>(dynamic v, {Type typeR, int depth = 0}) {
  Type type = typeR ?? R;
  if (v == null) return null;
  if (isPrimitive(type)) return JsonValueTransformer.parse<R>(v);
  if (isList(type)) {
    var list = (v as List)
        .map((o) => _innerValueParser(o, typeR: o.runtimeType))
        .toList();
    switch (type.toString()) {
      case "List<String>":
        return list.cast<String>().toList();
      case "List<int>":
        return list.cast<int>().toList();
      case "List<double>":
        return list.cast<double>().toList();
      case "List<bool>":
        return list.cast<bool>().toList();
      default:
        return list;
    }
  }

  if (type == OutputBean) return OutputBean.fromJson(v) as R;
  if (type == OutputData$0ListBean)
    return OutputData$0ListBean.fromJson(v) as R;
}

int _parserFuncRes(dynamic v) => JsonValueTransformer.parse<int>(v);

int _parserFuncData$0ListType(dynamic v) => JsonValueTransformer.parse<int>(v);

List<List<dynamic>> _parserFuncData$0ListTeam(dynamic v) => (v as List)
    .map<List<dynamic>>((o) => _innerValueParser<List<dynamic>>(o))
    .toList();

int _parserFuncData$0ListB(dynamic v) => JsonValueTransformer.parse<int>(v);

double _parserFuncData$0ListReward(dynamic v) =>
    JsonValueTransformer.parse<double>(v);

int _parserFuncData$0ListMold(dynamic v) => JsonValueTransformer.parse<int>(v);

List<OutputData$0ListBean> _parserFuncData(dynamic v) => (v as List)
    .map<OutputData$0ListBean>(
        (o) => _innerValueParser<OutputData$0ListBean>(o))
    .toList();

int _parserFuncM(dynamic v) => JsonValueTransformer.parse<int>(v);
