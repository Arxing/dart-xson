import 'package:xson/xson.dart';

main() {
  var json1 = {"a": 100, "b": 200};
  var json2 = {
    "a": 666,
    "b": 8888,
    "c": [10]
  };
  var jsonInfo1 = JsonInfo.parse(json1);
  print(jsonInfo1);
  var jsonInfo2 = JsonInfo.parse(json2);
  print(jsonInfo2);

  print("same ${jsonInfo1 == jsonInfo2}");
}
