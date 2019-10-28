import 'package:xson/xson.dart';

class Xson {
  String encodeFromJsonElement(JsonElement element, {bool prettify = false, int indent = 2}) =>
      element.toJsonString(prettify: prettify, indent: indent);

  String encode(dynamic object, {bool prettify = false, int indent = 2}) {
    if (object == null) throw "encoded object can not be null";
    JsonElement element = (object is JsonElement) ? object : JsonElement.fromJson(object);
    return element.toJsonString(prettify: prettify, indent: indent);
  }

  JsonElement decodeToJsonElement(String json) => JsonElement.fromJsonString(json);

  dynamic decode(String json) => JsonElement.fromJsonString(json).toJson();
}

Xson xson = Xson();
