import 'package:xson/xson.dart';

typedef void JsonSerializeCallback(JsonElement node, dynamic parent, int depth);

class JsonSerializer {

  dynamic toJson(JsonElement element, {JsonSerializeCallback callback}) => _internalParse(element, null, 0, callback);

  dynamic _internalParse(JsonElement node, dynamic parent, int depth, JsonSerializeCallback callback) {
    JsonType jsonToken = JsonType.fromElement(node);
    if (callback != null) callback(node, parent, depth);
    dynamic result;
    switch (jsonToken) {
      case JsonType.NULL:
        result = null;
        break;
      case JsonType.INT:
        result = node.asInt;
        break;
      case JsonType.DOUBLE:
        result = node.asDouble;
        break;
      case JsonType.BOOL:
        result = node.asBool;
        break;
      case JsonType.STRING:
        result = node.asString;
        break;
      case JsonType.OBJECT:
        Map<dynamic, dynamic> map = Map<String, dynamic>();
        node.asObject.entries.forEach((entry) => map[entry.key] = _internalParse(entry.value, map, depth + 1, callback));
        result = map;
        break;
      case JsonType.ARRAY:
        List<dynamic> list = List<dynamic>();
        JsonArray array = node.asArray;
        array.forEach((childNode) => list.add(_internalParse(childNode, list, depth + 1, callback)));
        result = list;
        break;
    }
    return result;
  }
}
