import 'package:xson/xson.dart';

class JsonFormatter {
  int _indentSize;

  JsonFormatter({int indentSize}) : _indentSize = indentSize ?? 2;

  String simplify(String source) => _traversal(JsonElement.fromJsonString(source), true, 0);

  String prettify(String source) => _traversal(JsonElement.fromJsonString(source), false, 0);

  String _buildIndent(int depth) => " " * depth * _indentSize;

  String _traversal(JsonElement node, bool simple, int depth) {
    JsonType jsonType = JsonType.fromElement(node);
    String result;
    switch (jsonType) {
      case JsonType.ARRAY:
        JsonArray array = node.asArray;
        if (array.isEmpty) {
          result = "[]";
        } else {
          var children = array.values.map((childNode) => _traversal(childNode, simple, depth + 1));
          if (simple) {
            result = "[${children.join(",")}]";
          } else {
            var childIndent = _buildIndent(depth + 1);
            var endIndent = _buildIndent(depth);
            var s = children.map((child) => "$childIndent$child").join(",\n");
            result = "[\n$s\n$endIndent]";
          }
        }
        break;
      case JsonType.OBJECT:
        JsonObject object = node.asObject;
        if (object.keys.isEmpty) {
          result = "{}";
        } else {
          var children = object.entries.map((entry) => "\"${entry.key}\": ${_traversal(entry.value, simple, depth + 1)}");
          if (simple) {
            result = "{${children.join(",")}}";
          } else {
            var childIndent = _buildIndent(depth + 1);
            var endIndent = _buildIndent(depth);
            var s = children.map((child) => "$childIndent$child").join(",\n");
            result = "{\n$s\n$endIndent}";
          }
        }
        break;
      case JsonType.INT:
        result = "${node.asInt}";
        break;
      case JsonType.DOUBLE:
        result = "${node.asDouble}";
        break;
      case JsonType.STRING:
        result = "\"${node.asString}\"";
        break;
      case JsonType.BOOL:
        result = "${node.asBool}";
        break;
      case JsonType.NULL:
        result = "null";
        break;
    }
    return result;
  }
}
