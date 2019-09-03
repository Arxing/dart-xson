import 'package:xson/xson.dart';

class JsonPrimitive extends JsonElement {
  dynamic _value;

  @override
  JsonElement deepCopy() {
    return this;
  }

  JsonPrimitive.of(this._value);

  JsonPrimitive.ofBool(bool val) : this.of(val);

  JsonPrimitive.ofNum(num val) : this.of(val);

  JsonPrimitive.ofString(String val) : this.of(val);

  bool get isBool => _value is bool;

  bool get asBool => isBool ? _value as bool : _value.toString().toLowerCase() == 'true';

  bool get isNum => _value is num;

  bool get isInt => isNum && asNum.ceil()==asNum.toInt();

  num get asNum => _value is String ? num.tryParse(_value) : _value as num;

  bool get isString => _value is String;

  String get asString => isNum ? asNum.toString() : isBool ? asBool.toString() : _value as String;

  double get asDouble => isNum ? asNum.toDouble() : double.parse(asString);

  int get asInt => isNum ? asNum.toInt() : int.tryParse(asString);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is JsonPrimitive &&
              runtimeType == other.runtimeType &&
              _value == other._value;

  @override
  int get hashCode {
    if(_value==null) return 31;
    return _value.hashCode;
  }
}
