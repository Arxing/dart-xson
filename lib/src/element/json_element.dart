import 'package:xson/xson.dart';

abstract class JsonElement {
  static JsonSerializer _serializer = JsonSerializer();
  static JsonDeserializer _deserializer = JsonDeserializer();

  JsonElement();

  JsonElement deepCopy();

  bool get isArray => this is JsonArray;

  bool get isObject => this is JsonObject;

  bool get isPrimitive => this is JsonPrimitive;

  bool get isNull => this is JsonNull;

  JsonObject get asObject {
    if (isObject) return this as JsonObject;
    throw JsonIllegalStateException('Not a JSON Object: ${this.toString()}');
  }

  JsonArray get asArray {
    if (isArray) return this as JsonArray;
    throw JsonIllegalStateException('Not a JSON Array: ${this.toString()}');
  }

  JsonPrimitive get asPrimitive {
    if (isPrimitive) return this as JsonPrimitive;
    throw JsonIllegalStateException('Not a JSON Primitive: ${this.toString()}');
  }

  JsonNull get asNull {
    if (isNull) return this as JsonNull;
    throw JsonIllegalStateException('Not a JSON Null: ${this.toString()}');
  }

  num get asNum {
    if (isPrimitive && asPrimitive.isNum) return asPrimitive.asNum;
    throw JsonIllegalStateException('Not a Num: ${this.toString()}');
  }

  int get asInt {
    if (isPrimitive && asPrimitive.isInt) return asPrimitive.asInt;
    throw JsonIllegalStateException('Not a int: ${this.toString()}');
  }

  double get asDouble {
    if (isPrimitive && asPrimitive.isDouble) return asPrimitive.asDouble;
    throw JsonIllegalStateException('Not a double: ${this.toString()}');
  }

  bool get asBool {
    if (isPrimitive && asPrimitive.isBool) return asPrimitive.asBool;
    throw JsonIllegalStateException('Not a bool: ${this.toString()}');
  }

  String get asString {
    if (isPrimitive && asPrimitive.isString) return asPrimitive.asString;
    throw JsonIllegalStateException('Not a String: ${this.toString()}');
  }

  @override
  String toString() => toJsonString();

  void traversalChildrenNode(JsonSerializeCallback callback) => toJson(callback: callback);

  dynamic toJson({JsonSerializeCallback callback}) => _serializer.toJson(this, callback: callback);

  String toJsonString({bool prettify = false, int indent, JsonSerializeCallback callback}) {
    JsonFormatter formatter = JsonFormatter(indentSize: indent);
    String jsonString = jsonEncode(toJson(callback: callback));
    return prettify ? formatter.prettify(jsonString) : formatter.simplify(jsonString);
  }

  factory JsonElement.fromJson(dynamic json, {JsonDeserializeCallback callback}) =>
      _deserializer.fromJson(json, callback: callback);

  factory JsonElement.fromJsonString(String json, {JsonDeserializeCallback callback}) =>
      JsonElement.fromJson(jsonDecode(json), callback: callback);
}
