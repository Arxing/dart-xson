import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'output.g.dart';

@JsonSerializable()
class OutputBean {
  bool _rootIsList = false;

  /// .list
  List<dynamic> list;

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
