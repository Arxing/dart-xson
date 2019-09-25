import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:xson/src/json_value_transformer.dart';
part 'output.g.dart';

@JsonSerializable()
class OutputBean {
  bool _rootIsList = false;
  @JsonKey(name: "list")
  List<OutputList$0ListBean> list;

  OutputBean({this.list});
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
class OutputList$0ListBean {
  bool _rootIsList = false;
  @JsonKey(fromJson: _parserFuncList$0ListA, name: "a")
  String a;
  @JsonKey(fromJson: _parserFuncList$0ListB, name: "b")
  bool b;

  OutputList$0ListBean({this.a, this.b});
  factory OutputList$0ListBean.fromJson(dynamic json) {
    if (json is Map) return _$OutputList$0ListBeanFromJson(json);
    if (json is List) return _$OutputList$0ListBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputList$0ListBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

String _parserFuncList$0ListA(dynamic v) =>
    JsonValueTransformer.parse<String>(v);

bool _parserFuncList$0ListB(dynamic v) => JsonValueTransformer.parse<bool>(v);
