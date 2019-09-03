import 'package:xson/xson.dart';

abstract class JsonElement {
  JsonElement deepCopy();

  bool get isJsonArray => this is JsonArray;

  bool get isJsonObject => this is JsonObject;

  bool get isJsonPrimitive => this is JsonPrimitive;

  bool get isJsonNull => this is JsonNull;

  JsonObject get asJsonObject {
    if (isJsonObject) return this as JsonObject;
    throw 'Not a JSON Object: ${this.toString()}';
  }

  JsonArray get asJsonArray {
    if (isJsonArray) return this as JsonArray;
    throw 'Not a JSON Array: ${this.toString()}';
  }

  JsonPrimitive get asJsonPrimitive {
    if (isJsonPrimitive) return this as JsonPrimitive;
    throw 'Not a JSON Primitive: ${this.toString()}';
  }

  JsonNull get asJsonNull {
    if (isJsonNull) return this as JsonNull;
    throw 'Not a JSON Null: ${this.toString()}';
  }

  bool get asBool => throw UnsupportedError('');

  num get asNum => throw UnsupportedError('');

  String get asString => throw UnsupportedError('');

  double get asDouble => throw UnsupportedError('');

  int get asInt => throw UnsupportedError('');

  @override
  String toString() {
    return super.toString();
  }
}
