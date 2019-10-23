import 'dart:io';
import 'package:xson/xson.dart' as xson;

void main() async {
  File makeFile = File('./example/sample.json');
  File outputFile = File('./example/generated/output.dart');
  await xson.generateJsonBeanFile(makeFile.readAsStringSync(), outputFile, runBuildRunner: true);
}
