import 'dart:io';

import 'package:xson/xson.dart' as xson;

import 'generated/output.dart';

main() async {
  File make = File('./example/sample.json');
  File output = File('./example/generated/output.dart');
  File inputJson = File('./example/input.json');
//  await xson.generateJsonBeanFile(make.readAsStringSync(), output, runBuildRunner: true);
//
  String jsonSource = inputJson.readAsStringSync();
  jsonSource = xson.readJsonIgnoreComments(jsonSource);
  print("source=$jsonSource");
  dynamic json = xson.jsonDecode(jsonSource);
  OutputBean outputBean = OutputBean.fromJson(json);
  String encode = xson.jsonEncode(outputBean.toJson());
  print(encode);
}
