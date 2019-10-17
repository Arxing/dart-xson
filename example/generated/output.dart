import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:xson_utils/xson_utils.dart';

part 'output.g.dart';

@JsonSerializable()
class OutputBean {
  bool _rootIsList = false;
  @JsonKey(fromJson: _parserFuncRes)
  int res;
  @JsonKey(fromJson: _parserFuncList)
  List<OutputList$0ListBean> list;
  @JsonKey(fromJson: _parserFuncSlv)
  int slv;

  OutputBean({this.res, this.list, this.slv});

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
  @JsonKey(fromJson: _parserFuncList$0ListOrderId, name: "order_id")
  String orderId;
  @JsonKey(fromJson: _parserFuncList$0ListItemid)
  int itemid;
  @JsonKey(fromJson: _parserFuncList$0ListTotal)
  int total;
  @JsonKey(fromJson: _parserFuncList$0ListType)
  int type;
  @JsonKey(fromJson: _parserFuncList$0ListReward)
  String reward;
  @JsonKey(fromJson: _parserFuncList$0ListMoney)
  String money;
  @JsonKey(fromJson: _parserFuncList$0ListTime)
  int time;
  @JsonKey(fromJson: _parserFuncList$0ListRebate)
  String rebate;
  @JsonKey(fromJson: _parserFuncList$0ListModel)
  String model;
  @JsonKey(fromJson: _parserFuncList$0ListWay)
  String way;
  @JsonKey(fromJson: _parserFuncList$0ListNum)
  List<int> num;
  @JsonKey(fromJson: _parserFuncList$0ListFa)
  List<OutputList$0ListFa$0ListBean> fa;
  @JsonKey()
  OutputList$0ListThreeBean three;
  @JsonKey()
  OutputList$0ListFiveBean five;
  @JsonKey(fromJson: _parserFuncList$0ListStop)
  int stop;
  @JsonKey(fromJson: _parserFuncList$0ListIsJa)
  int isJa;
  @JsonKey(fromJson: _parserFuncList$0ListPrice)
  List<String> price;
  @JsonKey(fromJson: _parserFuncList$0ListIfg)
  int ifg;
  @JsonKey(fromJson: _parserFuncList$0ListName)
  String name;
  @JsonKey(fromJson: _parserFuncList$0ListLv)
  int lv;
  @JsonKey(fromJson: _parserFuncList$0ListRate)
  int rate;
  @JsonKey(fromJson: _parserFuncList$0ListNumber)
  int number;
  @JsonKey(fromJson: _parserFuncList$0ListAllmoney)
  int allmoney;
  @JsonKey(fromJson: _parserFuncList$0ListYj)
  double yj;
  @JsonKey(fromJson: _parserFuncList$0ListG)
  double g;
  @JsonKey(fromJson: _parserFuncList$0ListT)
  int t;

  OutputList$0ListBean(
      {this.orderId,
      this.itemid,
      this.total,
      this.type,
      this.reward,
      this.money,
      this.time,
      this.rebate,
      this.model,
      this.way,
      this.num,
      this.fa,
      this.three,
      this.five,
      this.stop,
      this.isJa,
      this.price,
      this.ifg,
      this.name,
      this.lv,
      this.rate,
      this.number,
      this.allmoney,
      this.yj,
      this.g,
      this.t});

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

@JsonSerializable()
class OutputList$0ListFiveBean {
  bool _rootIsList = false;
  @JsonKey(fromJson: _parserFuncList$0ListFiveNumber)
  List<List<String>> number;
  @JsonKey(fromJson: _parserFuncList$0ListFiveB)
  String b;
  @JsonKey(fromJson: _parserFuncList$0ListFiveQs)
  String qs;

  OutputList$0ListFiveBean({this.number, this.b, this.qs});

  factory OutputList$0ListFiveBean.fromJson(dynamic json) {
    if (json is Map) return _$OutputList$0ListFiveBeanFromJson(json);
    if (json is List) return _$OutputList$0ListFiveBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputList$0ListFiveBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class OutputList$0ListThreeBean {
  bool _rootIsList = false;
  @JsonKey(fromJson: _parserFuncList$0ListThreeNumber)
  List<List<String>> number;
  @JsonKey(fromJson: _parserFuncList$0ListThreeB)
  String b;
  @JsonKey(fromJson: _parserFuncList$0ListThreeQs)
  String qs;

  OutputList$0ListThreeBean({this.number, this.b, this.qs});

  factory OutputList$0ListThreeBean.fromJson(dynamic json) {
    if (json is Map) return _$OutputList$0ListThreeBeanFromJson(json);
    if (json is List) return _$OutputList$0ListThreeBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputList$0ListThreeBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

@JsonSerializable()
class OutputList$0ListFa$0ListBean {
  bool _rootIsList = false;
  @JsonKey(fromJson: _parserFuncList$0ListFa$0ListResult)
  List<dynamic> result;
  @JsonKey(fromJson: _parserFuncList$0ListFa$0ListStatus)
  int status;
  @JsonKey(fromJson: _parserFuncList$0ListFa$0ListDay)
  int day;
  @JsonKey(fromJson: _parserFuncList$0ListFa$0ListTeamAName, name: "team_a_name")
  String teamAName;
  @JsonKey(fromJson: _parserFuncList$0ListFa$0ListTeamBName, name: "team_b_name")
  String teamBName;
  @JsonKey(fromJson: _parserFuncList$0ListFa$0ListWant)
  List<List<dynamic>> want;
  @JsonKey(fromJson: _parserFuncList$0ListFa$0ListLenName, name: "len_name")
  String lenName;

  OutputList$0ListFa$0ListBean({this.result, this.status, this.day, this.teamAName, this.teamBName, this.want, this.lenName});

  factory OutputList$0ListFa$0ListBean.fromJson(dynamic json) {
    if (json is Map) return _$OutputList$0ListFa$0ListBeanFromJson(json);
    if (json is List) return _$OutputList$0ListFa$0ListBeanFromJson({'data': json});
    throw 'fromJson parameter must be List or Map, but you give ${json?.runtimeType}';
  }

  bool get isJsonList => _rootIsList;

  dynamic toJson() {
    Map<String, dynamic> json = _$OutputList$0ListFa$0ListBeanToJson(this);
    return _rootIsList ? json['data'] : json;
  }
}

dynamic _innerValueParser<R>(dynamic v, {Type typeR, int depth = 0}) {
  Type type = typeR ?? R;
  if (v == null) return null;
  if (isPrimitive(type)) return JsonValueTransformer.parse<R>(v);
  if (isList(type)) {
    var list = (v as List).map((o) => _innerValueParser(o, typeR: o.runtimeType, depth: depth + 1)).toList();
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
  if (type == OutputList$0ListBean) return OutputList$0ListBean.fromJson(v) as R;
  if (type == OutputList$0ListFa$0ListBean) return OutputList$0ListFa$0ListBean.fromJson(v) as R;
  if (type == OutputList$0ListThreeBean) return OutputList$0ListThreeBean.fromJson(v) as R;
  if (type == OutputList$0ListFiveBean) return OutputList$0ListFiveBean.fromJson(v) as R;
}

int _parserFuncRes(dynamic v) => JsonValueTransformer.parse<int>(v);

String _parserFuncList$0ListOrderId(dynamic v) => JsonValueTransformer.parse<String>(v);

int _parserFuncList$0ListItemid(dynamic v) => JsonValueTransformer.parse<int>(v);

int _parserFuncList$0ListTotal(dynamic v) => JsonValueTransformer.parse<int>(v);

int _parserFuncList$0ListType(dynamic v) => JsonValueTransformer.parse<int>(v);

String _parserFuncList$0ListReward(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncList$0ListMoney(dynamic v) => JsonValueTransformer.parse<String>(v);

int _parserFuncList$0ListTime(dynamic v) => JsonValueTransformer.parse<int>(v);

String _parserFuncList$0ListRebate(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncList$0ListModel(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncList$0ListWay(dynamic v) => JsonValueTransformer.parse<String>(v);

List<int> _parserFuncList$0ListNum(dynamic v) => (v as List)?.map<int>((o) => JsonValueTransformer.parse<int>(o))?.toList();

List<dynamic> _parserFuncList$0ListFa$0ListResult(dynamic v) => (v as List)?.map<dynamic>((o) => _innerValueParser<dynamic>(o))?.toList();

int _parserFuncList$0ListFa$0ListStatus(dynamic v) => JsonValueTransformer.parse<int>(v);

int _parserFuncList$0ListFa$0ListDay(dynamic v) => JsonValueTransformer.parse<int>(v);

String _parserFuncList$0ListFa$0ListTeamAName(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncList$0ListFa$0ListTeamBName(dynamic v) => JsonValueTransformer.parse<String>(v);

List<List<dynamic>> _parserFuncList$0ListFa$0ListWant(dynamic v) =>
    (v as List)?.map<List<dynamic>>((o) => _innerValueParser<List<dynamic>>(o))?.toList();

String _parserFuncList$0ListFa$0ListLenName(dynamic v) => JsonValueTransformer.parse<String>(v);

List<OutputList$0ListFa$0ListBean> _parserFuncList$0ListFa(dynamic v) =>
    (v as List)?.map<OutputList$0ListFa$0ListBean>((o) => _innerValueParser<OutputList$0ListFa$0ListBean>(o))?.toList();

List<List<String>> _parserFuncList$0ListThreeNumber(dynamic v) =>
    (v as List)?.map<List<String>>((o) => _innerValueParser<List<String>>(o))?.toList();

String _parserFuncList$0ListThreeB(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncList$0ListThreeQs(dynamic v) => JsonValueTransformer.parse<String>(v);

List<List<String>> _parserFuncList$0ListFiveNumber(dynamic v) =>
    (v as List)?.map<List<String>>((o) => _innerValueParser<List<String>>(o))?.toList();

String _parserFuncList$0ListFiveB(dynamic v) => JsonValueTransformer.parse<String>(v);

String _parserFuncList$0ListFiveQs(dynamic v) => JsonValueTransformer.parse<String>(v);

int _parserFuncList$0ListStop(dynamic v) => JsonValueTransformer.parse<int>(v);

int _parserFuncList$0ListIsJa(dynamic v) => JsonValueTransformer.parse<int>(v);

List<String> _parserFuncList$0ListPrice(dynamic v) => (v as List)?.map<String>((o) => JsonValueTransformer.parse<String>(o))?.toList();

int _parserFuncList$0ListIfg(dynamic v) => JsonValueTransformer.parse<int>(v);

String _parserFuncList$0ListName(dynamic v) => JsonValueTransformer.parse<String>(v);

int _parserFuncList$0ListLv(dynamic v) => JsonValueTransformer.parse<int>(v);

int _parserFuncList$0ListRate(dynamic v) => JsonValueTransformer.parse<int>(v);

int _parserFuncList$0ListNumber(dynamic v) => JsonValueTransformer.parse<int>(v);

int _parserFuncList$0ListAllmoney(dynamic v) => JsonValueTransformer.parse<int>(v);

double _parserFuncList$0ListYj(dynamic v) => JsonValueTransformer.parse<double>(v);

double _parserFuncList$0ListG(dynamic v) => JsonValueTransformer.parse<double>(v);

int _parserFuncList$0ListT(dynamic v) => JsonValueTransformer.parse<int>(v);

List<OutputList$0ListBean> _parserFuncList(dynamic v) =>
    (v as List)?.map<OutputList$0ListBean>((o) => _innerValueParser<OutputList$0ListBean>(o))?.toList();

int _parserFuncSlv(dynamic v) => JsonValueTransformer.parse<int>(v);
