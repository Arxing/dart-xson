import 'package:xson/xson.dart';

class JsonPrimitive extends JsonElement {
  dynamic _value;

  @override
  JsonElement deepCopy() => this;

  JsonPrimitive.of(this._value);

  JsonPrimitive.ofBool(bool val) : this.of(val);

  JsonPrimitive.ofNum(num val) : this.of(val);

  JsonPrimitive.ofString(String val) : this.of(val);

  bool get isBool => _value is bool;

  bool get asBool {
    if (isBool) return _value as bool;
    var s = asString.toLowerCase();
    return s == "true" ? true : s == "false" ? false : (throw JsonIllegalStateException("$_value can not parse to bool"));
  }

  bool get isNum => _value is num;

  bool get isInt => _value is int;

  bool get isDouble => _value is double;

  num get asNum {
    if (isNum) return _value as num;
    return num.tryParse(asString) ?? JsonIllegalStateException((throw "$_value can not parse to num"));
  }

  double get asDouble {
    if (isNum) {
      if (isDouble) return _value as double;
      if (isInt) return asInt.toDouble();
    }
    return double.tryParse(asString) ?? JsonIllegalStateException((throw "$_value can not parse to double"));
  }

  int get asInt {
    if (isInt) return _value as int;
    return int.tryParse(asString) ?? JsonIllegalStateException((throw "$_value can not parse to int"));
  }

  bool get isString => _value is String;

  String get asString {
    if (isNum) return asNum.toString();
    if (isBool) return asBool.toString();
    if (isString) return _value as String;
    return _value.toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is JsonPrimitive && runtimeType == other.runtimeType && _value == other._value;

  @override
  int get hashCode => _value.hashCode;
}
