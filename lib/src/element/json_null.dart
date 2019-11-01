import 'package:xson/xson.dart';

class JsonNull extends JsonElement {
  JsonNull.newInstance();

  @override
  JsonElement deepCopy() => this;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  bool operator ==(other) => other is JsonNull;
}
