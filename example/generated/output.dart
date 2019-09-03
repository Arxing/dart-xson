
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'output.g.dart';

@JsonSerializable()
class RootBean {
  AppleBean apple;

  RootBean({this.apple});
  factory RootBean.fromJson(Map<String, dynamic> json) => _$RootBeanFromJson(json);

  Map<String, dynamic> toJson()  => _$RootBeanToJson(this);
}

@JsonSerializable()
class AppleBean {
  AppleBananaBean banana;

  AppleBean({this.banana});
  factory AppleBean.fromJson(Map<String, dynamic> json) => _$AppleBeanFromJson(json);

  Map<String, dynamic> toJson()  => _$AppleBeanToJson(this);
}

@JsonSerializable()
class AppleBananaBean {
  List<Map> food;

  AppleBananaBean({this.food});
  factory AppleBananaBean.fromJson(Map<String, dynamic> json) => _$AppleBananaBeanFromJson(json);

  Map<String, dynamic> toJson()  => _$AppleBananaBeanToJson(this);
}

@JsonSerializable()
class AppleBananaFood$0ListBean {
  List<List> jo;

  AppleBananaFood$0ListBean({this.jo});
  factory AppleBananaFood$0ListBean.fromJson(Map<String, dynamic> json) => _$AppleBananaFood$0ListBeanFromJson(json);

  Map<String, dynamic> toJson()  => _$AppleBananaFood$0ListBeanToJson(this);
}


