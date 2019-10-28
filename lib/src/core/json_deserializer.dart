import 'package:xson/xson.dart';

typedef void JsonDeserializeCallback(dynamic node, JsonElement parent, int depth);

class JsonDeserializer {

  JsonElement fromJson(dynamic json, {JsonDeserializeCallback callback}) => _internalParse(json, null, 0, callback);

  JsonElement _internalParse(dynamic node, JsonElement parent, int depth, JsonDeserializeCallback callback) {
    JsonType jsonToken = JsonType.fromJson(node);
    if (callback != null) callback(node, parent, depth);
    JsonElement result;
    switch (jsonToken) {
      case JsonType.NULL:
        result = JsonNull.INSTANCE;
        break;
      case JsonType.INT:
      case JsonType.DOUBLE:
        result = JsonPrimitive.ofNum(node);
        break;
      case JsonType.BOOL:
        result = JsonPrimitive.ofBool(node);
        break;
      case JsonType.STRING:
        result = JsonPrimitive.ofString(node);
        break;
      case JsonType.OBJECT:
        JsonObject object = JsonObject();
        Map<dynamic, dynamic> map = node;
        map.entries.forEach((entry) => object[entry.key] = _internalParse(entry.value, object, depth + 1, callback));
        result = object;
        break;
      case JsonType.ARRAY:
        JsonArray array = JsonArray.empty();
        List<dynamic> list = node;
        list.forEach((childNode) => array.add(_internalParse(childNode, array, depth + 1, callback)));
        result = array;
        break;
    }
    return result;
  }
}
