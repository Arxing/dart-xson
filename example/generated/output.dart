
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'output.g.dart';

@JsonSerializable()
class OutputBean {
  bool _rootIsList=false;
  OutputA1Bean a1;
  @JsonKey(name: '100')
  Output$100Bean $100;

  OutputBean({this.a1, this.$100});
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
class Output$100Bean {
  bool _rootIsList=false;
  Output$100Aa2Bean aa2;

  Output$100Bean({this.aa2});
  factory Output$100Bean.fromJson(dynamic json){
    if (json is Map) return _$Output$100BeanFromJson(json);
    if (json is List) return _$Output$100BeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$Output$100BeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class Output$100Aa2Bean {
  bool _rootIsList=false;
  List<Output$100Aa2Aaa2$0ListBean> aaa2;

  Output$100Aa2Bean({this.aaa2});
  factory Output$100Aa2Bean.fromJson(dynamic json){
    if (json is Map) return _$Output$100Aa2BeanFromJson(json);
    if (json is List) return _$Output$100Aa2BeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$Output$100Aa2BeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class Output$100Aa2Aaa2$0ListBean {
  bool _rootIsList=false;
  Output$100Aa2Aaa2$0ListAaaa2Bean aaaa2;

  Output$100Aa2Aaa2$0ListBean({this.aaaa2});
  factory Output$100Aa2Aaa2$0ListBean.fromJson(dynamic json){
    if (json is Map) return _$Output$100Aa2Aaa2$0ListBeanFromJson(json);
    if (json is List) return _$Output$100Aa2Aaa2$0ListBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$Output$100Aa2Aaa2$0ListBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class Output$100Aa2Aaa2$0ListAaaa2Bean {
  bool _rootIsList=false;

  Output$100Aa2Aaa2$0ListAaaa2Bean();
  factory Output$100Aa2Aaa2$0ListAaaa2Bean.fromJson(dynamic json){
    if (json is Map) return _$Output$100Aa2Aaa2$0ListAaaa2BeanFromJson(json);
    if (json is List) return _$Output$100Aa2Aaa2$0ListAaaa2BeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$Output$100Aa2Aaa2$0ListAaaa2BeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class OutputA1Bean {
  bool _rootIsList=false;
  List<OutputA1Aa1$0ListBean> aa1;

  OutputA1Bean({this.aa1});
  factory OutputA1Bean.fromJson(dynamic json){
    if (json is Map) return _$OutputA1BeanFromJson(json);
    if (json is List) return _$OutputA1BeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputA1BeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class OutputA1Aa1$0ListBean {
  bool _rootIsList=false;

  OutputA1Aa1$0ListBean();
  factory OutputA1Aa1$0ListBean.fromJson(dynamic json){
    if (json is Map) return _$OutputA1Aa1$0ListBeanFromJson(json);
    if (json is List) return _$OutputA1Aa1$0ListBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList  => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputA1Aa1$0ListBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}


