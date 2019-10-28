import 'package:xson/xson.dart';

class JsonObject extends JsonElement {
  final Map<String, JsonElement> _members = {};

  JsonObject();

  @override
  JsonElement deepCopy() {
    JsonObject result = JsonObject();
    _members.entries.forEach((o) => result.add(o.key, o.value.deepCopy()));
    return result;
  }

  void add(String property, JsonElement val) => _members[property] = (val == null) ? JsonNull.INSTANCE : val;

  void operator []=(String memberName, JsonElement element) => _members[memberName] = element;

  JsonElement operator [](String memberName) => _members[memberName];

  JsonElement remove(String property) => _members.remove(property);

  void addPropertyString(String property, String val) =>
      add(property, val == null ? JsonNull.INSTANCE : JsonPrimitive.ofString(val));

  void addPropertyBool(String property, bool val) => add(property, val == null ? JsonNull.INSTANCE : JsonPrimitive.ofBool(val));

  void addPropertyNum(String property, num val) => add(property, val == null ? JsonNull.INSTANCE : JsonPrimitive.ofNum(val));

  Iterable<MapEntry<String, JsonElement>> get entries => _members.entries;

  Iterable<String> get keys => _members.keys;

  int get length => _members.length;

  bool has(String memberName) => _members.containsKey(memberName);

  JsonElement get(String memberName) => _members[memberName];

  JsonPrimitive getAsJsonPrimitive(String memberName) => _members[memberName].asPrimitive;

  JsonArray getAsJsonArray(String memberName) => _members[memberName].asArray;

  JsonObject getAsJsonObject(String memberName) => _members[memberName].asObject;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is JsonObject && runtimeType == other.runtimeType && _members == other._members;

  @override
  int get hashCode => _members.hashCode;
}
