import 'dart:convert';
import 'dart:io';
import 'package:xson/xson.dart' as xson;
import 'generated/output.dart';

void main() async {
  JsonEncoder encoder = JsonEncoder.withIndent("  ");
  File inputJson = File('./example/input.json');
  String jsonSource = inputJson.readAsStringSync();
  jsonSource = xson.readJsonIgnoreComments(jsonSource);
  print("input=\n${encoder.convert(jsonDecode(jsonSource))}");
  dynamic json = xson.jsonDecode(jsonSource);
  OutputBean outputBean = OutputBean.fromJson(json);
  print("output=\n${encoder.convert(outputBean.toJson())}");
}
