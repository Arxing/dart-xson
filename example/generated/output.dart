import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:xson_utils/xson_utils.dart';
part 'output.g.dart';

@JsonSerializable()
class OutputBean {
  bool _rootIsList = false;
  @JsonKey()
  OutputAaBean aa;

  OutputBean({this.aa});
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
class OutputAaBean {
  bool _rootIsList = false;
  @JsonKey()
  List<dynamic> bb;

  OutputAaBean({this.bb});
  factory OutputAaBean.fromJson(dynamic json) {
    if (json is Map) return _$OutputAaBeanFromJson(json);
    if (json is List) return _$OutputAaBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputAaBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class OutputAaBb$1ListBean {
  bool _rootIsList = false;
  @JsonKey(fromJson: _parserFuncAaBb$1ListName)
  String name;
  @JsonKey(fromJson: _parserFuncAaBb$1ListAge)
  int age;
  @JsonKey(fromJson: _parserFuncAaBb$1ListCcc)
  int ccc;

  OutputAaBb$1ListBean({this.name, this.age, this.ccc});
  factory OutputAaBb$1ListBean.fromJson(dynamic json) {
    if (json is Map) return _$OutputAaBb$1ListBeanFromJson(json);
    if (json is List) return _$OutputAaBb$1ListBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputAaBb$1ListBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class OutputAaBb$0ListBean {
  bool _rootIsList = false;
  @JsonKey(fromJson: _parserFuncAaBb$0ListName)
  String name;
  @JsonKey(fromJson: _parserFuncAaBb$0ListAge)
  int age;

  OutputAaBb$0ListBean({this.name, this.age});
  factory OutputAaBb$0ListBean.fromJson(dynamic json) {
    if (json is Map) return _$OutputAaBb$0ListBeanFromJson(json);
    if (json is List) return _$OutputAaBb$0ListBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputAaBb$0ListBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

String _parserFuncAaBb$0ListName(dynamic v) =>
    JsonValueTransformer.parse<String>(v);

int _parserFuncAaBb$0ListAge(dynamic v) => JsonValueTransformer.parse<int>(v);

String _parserFuncAaBb$1ListName(dynamic v) =>
    JsonValueTransformer.parse<String>(v);

int _parserFuncAaBb$1ListAge(dynamic v) => JsonValueTransformer.parse<int>(v);

int _parserFuncAaBb$1ListCcc(dynamic v) => JsonValueTransformer.parse<int>(v);
