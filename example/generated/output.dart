
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'output.g.dart';

@JsonSerializable()
class OutputBean {
  bool _rootIsList=false;
  List<dynamic> data;

  OutputBean({this.data});
  factory OutputBean.fromJson(Map<String, dynamic> json) => _$OutputBeanFromJson(json);
  factory OutputBean.fromJsonString(String jsonSource){
    dynamic json = jsonDecode(jsonSource);
    bool rootIsList = json is List;
    if (rootIsList) json = {'data': json};
    var instance = OutputBean.fromJson(json);
    instance._rootIsList = rootIsList;
    return instance;
  }

  String toJsonString() {
    Map<String, dynamic> json = _$OutputBeanToJson(this);
    dynamic out = _rootIsList ? json['data'] : json;
    return jsonEncode(out);
  }
}

@JsonSerializable()
class Data$2ListBean {
  bool _rootIsList=false;
  int key2;
  List<dynamic> key3;

  Data$2ListBean({this.key2, this.key3});
  factory Data$2ListBean.fromJson(Map<String, dynamic> json) => _$Data$2ListBeanFromJson(json);
  factory Data$2ListBean.fromJsonString(String jsonSource){
    dynamic json = jsonDecode(jsonSource);
    bool rootIsList = json is List;
    if (rootIsList) json = {'data': json};
    var instance = Data$2ListBean.fromJson(json);
    instance._rootIsList = rootIsList;
    return instance;
  }

  String toJsonString() {
    Map<String, dynamic> json = _$Data$2ListBeanToJson(this);
    dynamic out = _rootIsList ? json['data'] : json;
    return jsonEncode(out);
  }
}

@JsonSerializable()
class Data$2ListKey3$1ListBean {
  bool _rootIsList=false;
  bool loop;
  bool lock;

  Data$2ListKey3$1ListBean({this.loop, this.lock});
  factory Data$2ListKey3$1ListBean.fromJson(Map<String, dynamic> json) => _$Data$2ListKey3$1ListBeanFromJson(json);
  factory Data$2ListKey3$1ListBean.fromJsonString(String jsonSource){
    dynamic json = jsonDecode(jsonSource);
    bool rootIsList = json is List;
    if (rootIsList) json = {'data': json};
    var instance = Data$2ListKey3$1ListBean.fromJson(json);
    instance._rootIsList = rootIsList;
    return instance;
  }

  String toJsonString() {
    Map<String, dynamic> json = _$Data$2ListKey3$1ListBeanToJson(this);
    dynamic out = _rootIsList ? json['data'] : json;
    return jsonEncode(out);
  }
}

@JsonSerializable()
class Data$1ListBean {
  bool _rootIsList=false;
  String key1;

  Data$1ListBean({this.key1});
  factory Data$1ListBean.fromJson(Map<String, dynamic> json) => _$Data$1ListBeanFromJson(json);
  factory Data$1ListBean.fromJsonString(String jsonSource){
    dynamic json = jsonDecode(jsonSource);
    bool rootIsList = json is List;
    if (rootIsList) json = {'data': json};
    var instance = Data$1ListBean.fromJson(json);
    instance._rootIsList = rootIsList;
    return instance;
  }

  String toJsonString() {
    Map<String, dynamic> json = _$Data$1ListBeanToJson(this);
    dynamic out = _rootIsList ? json['data'] : json;
    return jsonEncode(out);
  }
}


