import 'package:xson/xson.dart';

class JsonNull extends JsonElement {
  static final JsonNull INSTANCE = JsonNull();

  @override
  JsonElement deepCopy() {
    return INSTANCE;
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  bool operator ==(other) {
    return this == other || other is JsonNull;
  }
}
