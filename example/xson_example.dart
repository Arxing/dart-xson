import 'dart:io';

import 'package:xson/xson.dart' as xson;
import 'dart:convert';

main() {
  xson.generateJsonBeanFile(File('./example/sample.json').readAsStringSync(), File('./example/generated/output.dart'));
}
