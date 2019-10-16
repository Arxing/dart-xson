// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutputBean _$OutputBeanFromJson(Map<String, dynamic> json) {
  return OutputBean(
      res: _parserFuncRes(json['res']),
      list: _parserFuncList(json['list'] as List),
      slv: _parserFuncSlv(json['slv']));
}

Map<String, dynamic> _$OutputBeanToJson(OutputBean instance) =>
    <String, dynamic>{
      'res': instance.res,
      'list': instance.list,
      'slv': instance.slv
    };

OutputList$0ListBean _$OutputList$0ListBeanFromJson(Map<String, dynamic> json) {
  return OutputList$0ListBean(
      orderId: _parserFuncList$0ListOrderId(json['order_id']),
      itemid: _parserFuncList$0ListItemid(json['itemid']),
      total: _parserFuncList$0ListTotal(json['total']),
      type: _parserFuncList$0ListType(json['type']),
      reward: _parserFuncList$0ListReward(json['reward']),
      money: _parserFuncList$0ListMoney(json['money']),
      time: _parserFuncList$0ListTime(json['time']),
      rebate: _parserFuncList$0ListRebate(json['rebate']),
      model: _parserFuncList$0ListModel(json['model']),
      way: _parserFuncList$0ListWay(json['way']),
      num: _parserFuncList$0ListNum(json['num'] as List),
      fa: _parserFuncList$0ListFa(json['fa'] as List),
      three: json['three'] == null
          ? null
          : OutputList$0ListThreeBean.fromJson(json['three']),
      five: json['five'] == null
          ? null
          : OutputList$0ListFiveBean.fromJson(json['five']),
      stop: _parserFuncList$0ListStop(json['stop']),
      isJa: _parserFuncList$0ListIsJa(json['isJa']),
      price: _parserFuncList$0ListPrice(json['price'] as List),
      ifg: _parserFuncList$0ListIfg(json['ifg']),
      name: _parserFuncList$0ListName(json['name']),
      lv: _parserFuncList$0ListLv(json['lv']),
      rate: _parserFuncList$0ListRate(json['rate']),
      number: _parserFuncList$0ListNumber(json['number']),
      allmoney: _parserFuncList$0ListAllmoney(json['allmoney']),
      yj: _parserFuncList$0ListYj(json['yj']),
      g: _parserFuncList$0ListG(json['g']),
      t: _parserFuncList$0ListT(json['t']));
}

Map<String, dynamic> _$OutputList$0ListBeanToJson(
        OutputList$0ListBean instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'itemid': instance.itemid,
      'total': instance.total,
      'type': instance.type,
      'reward': instance.reward,
      'money': instance.money,
      'time': instance.time,
      'rebate': instance.rebate,
      'model': instance.model,
      'way': instance.way,
      'num': instance.num,
      'fa': instance.fa,
      'three': instance.three,
      'five': instance.five,
      'stop': instance.stop,
      'isJa': instance.isJa,
      'price': instance.price,
      'ifg': instance.ifg,
      'name': instance.name,
      'lv': instance.lv,
      'rate': instance.rate,
      'number': instance.number,
      'allmoney': instance.allmoney,
      'yj': instance.yj,
      'g': instance.g,
      't': instance.t
    };

OutputList$0ListFiveBean _$OutputList$0ListFiveBeanFromJson(
    Map<String, dynamic> json) {
  return OutputList$0ListFiveBean(
      number: _parserFuncList$0ListFiveNumber(json['number'] as List),
      b: _parserFuncList$0ListFiveB(json['b']),
      qs: _parserFuncList$0ListFiveQs(json['qs']));
}

Map<String, dynamic> _$OutputList$0ListFiveBeanToJson(
        OutputList$0ListFiveBean instance) =>
    <String, dynamic>{
      'number': instance.number,
      'b': instance.b,
      'qs': instance.qs
    };

OutputList$0ListThreeBean _$OutputList$0ListThreeBeanFromJson(
    Map<String, dynamic> json) {
  return OutputList$0ListThreeBean(
      number: _parserFuncList$0ListThreeNumber(json['number'] as List),
      b: _parserFuncList$0ListThreeB(json['b']),
      qs: _parserFuncList$0ListThreeQs(json['qs']));
}

Map<String, dynamic> _$OutputList$0ListThreeBeanToJson(
        OutputList$0ListThreeBean instance) =>
    <String, dynamic>{
      'number': instance.number,
      'b': instance.b,
      'qs': instance.qs
    };

OutputList$0ListFa$0ListBean _$OutputList$0ListFa$0ListBeanFromJson(
    Map<String, dynamic> json) {
  return OutputList$0ListFa$0ListBean(
      result: _parserFuncList$0ListFa$0ListResult(json['result'] as List),
      status: _parserFuncList$0ListFa$0ListStatus(json['status']),
      day: _parserFuncList$0ListFa$0ListDay(json['day']),
      teamAName: _parserFuncList$0ListFa$0ListTeamAName(json['team_a_name']),
      teamBName: _parserFuncList$0ListFa$0ListTeamBName(json['team_b_name']),
      want: _parserFuncList$0ListFa$0ListWant(json['want'] as List),
      lenName: _parserFuncList$0ListFa$0ListLenName(json['len_name']));
}

Map<String, dynamic> _$OutputList$0ListFa$0ListBeanToJson(
        OutputList$0ListFa$0ListBean instance) =>
    <String, dynamic>{
      'result': instance.result,
      'status': instance.status,
      'day': instance.day,
      'team_a_name': instance.teamAName,
      'team_b_name': instance.teamBName,
      'want': instance.want,
      'len_name': instance.lenName
    };
