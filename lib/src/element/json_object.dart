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

  void add(String key, JsonElement val) => this[key] = val;

  void operator []=(String key, JsonElement element) {
    element = element ?? JsonNull.newInstance();
    element.changeParent(this);
    _members[key] = element;
  }

  JsonElement operator [](String key) => _members[key];

  JsonElement remove(String key) {
    JsonElement element = _members.remove(key);
    element?.removeParent();
    return element;
  }

  void addProperty(String key, dynamic val) {
    JsonElement element;
    if (val == null) {
      element = JsonNull.newInstance();
    } else if (val is JsonElement) {
      element = val.deepCopy();
    } else if (val is int) {
      element = JsonPrimitive.ofInt(val);
    } else if (val is double) {
      element = JsonPrimitive.ofDouble(val);
    } else if (val is bool) {
      element = JsonPrimitive.ofBool(val);
    } else if (val is String) {
      element = JsonPrimitive.ofString(val);
    } else if (val is List || val is Map) {
      element = JsonElement.fromJson(val);
    } else {
      var json = xson.encode(val);
      element = xson.decodeToJsonElement(json);
    }
    add(key, element);
  }

  void addPropertyString(String key, String val) => addProperty(key, val);

  void addPropertyBool(String key, bool val) => addProperty(key, val);

  void addPropertyNum(String key, num val) => addProperty(key, val);

  void addPropertyInt(String key, int val) => addProperty(key, val);

  void addPropertyDouble(String key, double val) => addProperty(key, val);

  Iterable<MapEntry<String, JsonElement>> get entries => _members.entries;

  Iterable<String> get keys => _members.keys;

  int get length => _members.length;

  bool has(String key) => _members.containsKey(key);

  JsonElement get(String key) => _members[key];

  JsonPrimitive getAsJsonPrimitive(String key) => _members[key].asPrimitive;

  JsonArray getAsJsonArray(String key) => _members[key].asArray;

  JsonObject getAsJsonObject(String key) => _members[key].asObject;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is JsonObject && runtimeType == other.runtimeType && _members == other._members;

  @override
  int get hashCode => _members.hashCode;
}
