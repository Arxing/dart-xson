import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:xson_utils/xson_utils.dart';

part 'output.g.dart';

@JsonSerializable()
class OutputBean {
  bool _rootIsList = false;
  @JsonKey(fromJson: _parserFuncAa)
  List<List<List<int>>> aa;

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

dynamic _innerValueParser<R>(dynamic v, { typeR, int depth = 0}) {
  Type type = typeR ?? R;
  print("_innterParse(), resultType=$type, v=$v");
  if (v == null) {
    print("v is null, return null");
    return null;
  }
  if (isPrimitive(type)) {
    print("v is primitive, return JsonValueTransformer.parse()");
    return translateT<R>(v);
  }
  if (isList(type)) {

    print("v is List, foreach all element");
    var list = (v as List).map((o) => _innerValueParser(o, typeR: o.runtimeType, depth: depth + 1)).toList();
    print("finished foreach, cast list to $type");
    switch (type.toString()) {
      case "List<String>":
        return list.map((o) => translateT<String>(o)).toList();
      case "List<int>":
        return list.map((o) => translateT<int>(o)).toList();
      case "List<double>":
        return list.map((o) => translateT<double>(o)).toList();
      case "List<bool>":
        return list.map((o) => translateT<bool>(o)).toList();
      default:
        return list;
    }
  }
  print("v is other, return found bean parser");
  if (type == OutputBean) return OutputBean.fromJson(v) as R;
}

List<List<List<int>>> _parserFuncAa(dynamic v) => (v as List)?.map<List<List<int>>>((o) => _innerValueParser<List<List<int>>>(o))?.toList();
