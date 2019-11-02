import 'package:xson/xson.dart';

class JsonType {
  final int _value;
  final String _name;

  const JsonType._(this._value, this._name);

  factory JsonType(int value) {
    return values.firstWhere((o) => o.value == value, orElse: () => null);
  }

  int get value => _value;

  String get name => _name;

  Type get nativeType {
    switch (this) {
      case NULL:
        return Null;
      case DOUBLE:
        return double;
      case INT:
        return int;
      case BOOL:
        return bool;
      case STRING:
        return String;
      case OBJECT:
        return Map;
      case ARRAY:
        return List;
      default:
        throw JsonIllegalStateException();
    }
  }

  static List<JsonType> get values => [NULL, DOUBLE, INT, BOOL, STRING, OBJECT, ARRAY];

  static List<String> get names => [NULL.name, DOUBLE.name, INT.name, BOOL.name, STRING.name, OBJECT.name, ARRAY.name];

  factory JsonType.fromJson(dynamic element) {
    if (element == null) return JsonType.NULL;
    if (element is int) return JsonType.INT;
    if (element is double) return JsonType.DOUBLE;
    if (element is bool) return JsonType.BOOL;
    if (element is String) return JsonType.STRING;
    if (element is Map) return JsonType.OBJECT;
    if (element is List) return JsonType.ARRAY;
    throw JsonIllegalStateException("unknown type token on $element");
  }

  factory JsonType.fromElement(JsonElement element) {
    if (element.isNull) return JsonType.NULL;
    if (element.isPrimitive) {
      JsonPrimitive jsonPrimitive = element.asPrimitive;
      if (jsonPrimitive.isInt) return JsonType.INT;
      if (jsonPrimitive.isDouble) return JsonType.DOUBLE;
      if (jsonPrimitive.isBool) return JsonType.BOOL;
      if (jsonPrimitive.isString) return JsonType.STRING;
    }
    if (element.isObject) return JsonType.OBJECT;
    if (element.isArray) return JsonType.ARRAY;
    throw JsonIllegalStateException("unknown type token on $element");
  }

  static const NULL = JsonType._(_NULL, 'NULL');
  static const int _NULL = 1;

  static const DOUBLE = JsonType._(_DOUBLE, 'DOUBLE');
  static const int _DOUBLE = 2;

  static const INT = JsonType._(_INT, 'INT');
  static const int _INT = 3;

  static const BOOL = JsonType._(_BOOL, 'BOOL');
  static const int _BOOL = 4;

  static const STRING = JsonType._(_STRING, 'STRING');
  static const int _STRING = 5;

  static const OBJECT = JsonType._(_OBJECT, 'OBJECT');
  static const int _OBJECT = 6;

  static const ARRAY = JsonType._(_ARRAY, 'ARRAY');
  static const int _ARRAY = 7;
}
