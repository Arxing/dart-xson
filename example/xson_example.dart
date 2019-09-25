import 'dart:io';

import 'package:xson/xson.dart' as xson;

//import 'generated/output.dart';

main() async {
  File from = File('./example/sample.json');
  File output = File('./example/generated/output.dart');
  await xson.generateJsonBeanFile(from.readAsStringSync(), output, runBuildRunner: true);
//
//  String jsonSource = from.readAsStringSync();
//  jsonSource = xson.readJsonIgnoreComments(jsonSource);
//  dynamic json = xson.jsonDecode(jsonSource);
//  OutputBean outputBean = OutputBean.fromJson(json);
//  String encode = xson.jsonEncode(outputBean.toJson());
//  print(encode);
//  print(outputBean.map.first)
}
