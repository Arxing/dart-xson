import 'package:xson/xson.dart';

class JsonNull extends JsonElement {
  static final JsonNull INSTANCE = JsonNull._();

  JsonNull._();

  @override
  JsonElement deepCopy() => INSTANCE;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  bool operator ==(other) => this == other || other is JsonNull;
}
