import 'dart:io';

import 'package:xson/xson.dart' as xson;
import '../example/generated/output.dart';

main() async {
  File from = File('./example/sample.json');
  File output = File('./example/generated/output.dart');
  await xson.generateJsonBeanFile(from.readAsStringSync(), output, runBuildRunner: true);

  String jsonSource = from.readAsStringSync();
  dynamic json = xson.jsonDecode(jsonSource);
  OutputBean outputBean = OutputBean.fromJson(json);
  String encode = xson.jsonEncode(outputBean.toJson());
  print(encode);
}
