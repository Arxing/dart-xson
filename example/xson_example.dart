import 'package:xson/xson.dart';

var jsonString1 = """
{"aa":100, "b":[1,2,3], "c":{"c1":[666]}}
""";

var json1 = {
  "aa": 100,
  "b": [1, 2, 3],
  "c": {
    "c1": [666]
  }
};

void main() {
  // string to json element

  // way1
  JsonElement element1 = xson.decodeToJsonElement(jsonString1);
  // way2
  JsonElement element2 = JsonElement.fromJsonString(jsonString1);
  // way3
  JsonElement element3 = JsonElement.fromJson(json1);

  // element to other type
  JsonObject object = element1.asObject; // {"aa": 100, "b": [1, 2, 3], "c": {"c1": [666]}};
  JsonArray array = object["b"].asArray; // [1,2,3]
  array[0].asInt; // 1

  // element to string
  print(element1.toString());
  print(element1.toJsonString(prettify: true, indent: 4));
  print(xson.encodeFromJsonElement(element1, prettify: true));

  // element to json dynamic
  element1.toJson();

  // traversal all nodes of element
  JsonSerializeCallback callback = (JsonElement node, dynamic parent, int depth) {
    // do something
  };
  element1.traversalChildrenNode(callback);
}
