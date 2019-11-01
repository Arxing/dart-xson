import 'package:xson/xson.dart';

main() {
  var json = {
    "a": 100,
    "b": {
      "c": {
        "d": [
          {"e": 90}
        ]
      }
    }
  };

  JsonElement jsonElement = xson.jsonToJsonElement(json);
  print(jsonElement.asObject["b"].asObject.ancestor.isAncestor);
}
