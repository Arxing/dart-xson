
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'output.g.dart';

@JsonSerializable()
class OutputBean {
  bool _rootIsList=false;
  List<dynamic> data;

  OutputBean({this.data});
  factory OutputBean.fromJson(dynamic json){
    if (json is Map) return _$OutputBeanFromJson(json);
    if (json is List) return _$OutputBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class OutputData$4ListBean {
  bool _rootIsList=false;

  OutputData$4ListBean();
  factory OutputData$4ListBean.fromJson(dynamic json){
    if (json is Map) return _$OutputData$4ListBeanFromJson(json);
    if (json is List) return _$OutputData$4ListBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputData$4ListBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class OutputData$1ListBean {
  bool _rootIsList=false;
  @JsonKey(name: '100')
  int $100;

  OutputData$1ListBean({this.$100});
  factory OutputData$1ListBean.fromJson(dynamic json){
    if (json is Map) return _$OutputData$1ListBeanFromJson(json);
    if (json is List) return _$OutputData$1ListBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputData$1ListBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class OutputData$0ListBean {
  bool _rootIsList=false;
  OutputData$0ListA1Bean a1;
  OutputData$0ListA2Bean a2;

  OutputData$0ListBean({this.a1, this.a2});
  factory OutputData$0ListBean.fromJson(dynamic json){
    if (json is Map) return _$OutputData$0ListBeanFromJson(json);
    if (json is List) return _$OutputData$0ListBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputData$0ListBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class OutputData$0ListA2Bean {
  bool _rootIsList=false;
  OutputData$0ListA2Aa2Bean aa2;

  OutputData$0ListA2Bean({this.aa2});
  factory OutputData$0ListA2Bean.fromJson(dynamic json){
    if (json is Map) return _$OutputData$0ListA2BeanFromJson(json);
    if (json is List) return _$OutputData$0ListA2BeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputData$0ListA2BeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class OutputData$0ListA2Aa2Bean {
  bool _rootIsList=false;
  List<OutputData$0ListA2Aa2Aaa2$0ListBean> aaa2;

  OutputData$0ListA2Aa2Bean({this.aaa2});
  factory OutputData$0ListA2Aa2Bean.fromJson(dynamic json){
    if (json is Map) return _$OutputData$0ListA2Aa2BeanFromJson(json);
    if (json is List) return _$OutputData$0ListA2Aa2BeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputData$0ListA2Aa2BeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class OutputData$0ListA2Aa2Aaa2$0ListBean {
  bool _rootIsList=false;
  OutputData$0ListA2Aa2Aaa2$0ListAaaa2Bean aaaa2;

  OutputData$0ListA2Aa2Aaa2$0ListBean({this.aaaa2});
  factory OutputData$0ListA2Aa2Aaa2$0ListBean.fromJson(dynamic json){
    if (json is Map) return _$OutputData$0ListA2Aa2Aaa2$0ListBeanFromJson(json);
    if (json is List) return _$OutputData$0ListA2Aa2Aaa2$0ListBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputData$0ListA2Aa2Aaa2$0ListBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class OutputData$0ListA2Aa2Aaa2$0ListAaaa2Bean {
  bool _rootIsList=false;

  OutputData$0ListA2Aa2Aaa2$0ListAaaa2Bean();
  factory OutputData$0ListA2Aa2Aaa2$0ListAaaa2Bean.fromJson(dynamic json){
    if (json is Map) return _$OutputData$0ListA2Aa2Aaa2$0ListAaaa2BeanFromJson(json);
    if (json is List) return _$OutputData$0ListA2Aa2Aaa2$0ListAaaa2BeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputData$0ListA2Aa2Aaa2$0ListAaaa2BeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class OutputData$0ListA1Bean {
  bool _rootIsList=false;
  List<OutputData$0ListA1Aa1$0ListBean> aa1;

  OutputData$0ListA1Bean({this.aa1});
  factory OutputData$0ListA1Bean.fromJson(dynamic json){
    if (json is Map) return _$OutputData$0ListA1BeanFromJson(json);
    if (json is List) return _$OutputData$0ListA1BeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputData$0ListA1BeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class OutputData$0ListA1Aa1$0ListBean {
  bool _rootIsList=false;

  OutputData$0ListA1Aa1$0ListBean();
  factory OutputData$0ListA1Aa1$0ListBean.fromJson(dynamic json){
    if (json is Map) return _$OutputData$0ListA1Aa1$0ListBeanFromJson(json);
    if (json is List) return _$OutputData$0ListA1Aa1$0ListBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputData$0ListA1Aa1$0ListBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}


