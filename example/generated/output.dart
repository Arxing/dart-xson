import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:xson_utils/xson_utils.dart';
part 'output.g.dart';

@JsonSerializable()
class OutputBean {
  bool _rootIsList = false;
  @JsonKey(fromJson: _parserFuncAaa)
  List<List<dynamic>> aaa;

  OutputBean({this.aaa});
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

dynamic _innerValueParser<R>(dynamic v, {Type typeR, int depth = 0}) {
  print("=============================================== depth=$depth");
  Type type = typeR ?? R;
  print("R=$R typeR=$typeR   最後type=$type");
  print("json = $v");
  if (v == null) return null;
  if (isPrimitive(type)) return JsonValueTransformer.parse<R>(v);
  if (isList(type)) {
    print("bbb $type");
    var list = (v as List).map((o) {
      print("cccccc runtimeType=${o.runtimeType}");
      return _innerValueParser(o, typeR: o.runtimeType, depth: depth + 1);
    }).toList();
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
}

List<List<dynamic>> _parserFuncAaa(dynamic v) => (v as List)
    .map<List<dynamic>>((o) => _innerValueParser<List<dynamic>>(o))
    .toList();
