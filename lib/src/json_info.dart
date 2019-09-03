import 'package:xson/xson.dart';
import 'package:crypto/crypto.dart' as crypt;
import 'package:convert/convert.dart';

class JsonInfo {
  String type;
  Map<String, JsonInfo> objects = {};
  List<JsonInfo> arrays = [];

  JsonInfo.of(this.type, {this.objects, this.arrays}) {
    objects = objects ?? {};
    arrays = arrays ?? [];
  }

  factory JsonInfo.parse(dynamic obj) {
    if (obj == null) return JsonInfo.ofDynamic();
    if (obj is int) return JsonInfo.ofInt();
    if (obj is double) return JsonInfo.ofDouble();
    if (obj is bool) return JsonInfo.ofBool();
    if (obj is String) return JsonInfo.ofString();
    if (obj is Map<String, dynamic>) {
      JsonInfo root = JsonInfo.ofEmptyMap();
      Map<String, dynamic> map = obj;
      map.entries.forEach((entry) => root.objects[entry.key] = JsonInfo.parse(entry.value));
      return root;
    }
    if (obj is List<dynamic>) {
      JsonInfo root = JsonInfo.ofEmptyList();
      List<dynamic> list = obj;
      list.forEach((entry) => root.arrays.add(JsonInfo.parse(entry)));
      return root;
    }
    return JsonInfo.ofDynamic();
  }

  JsonInfo.ofDynamic() : this.of('dynamic');

  JsonInfo.ofInt() : this.of('int');

  JsonInfo.ofDouble() : this.of('double');

  JsonInfo.ofBool() : this.of('bool');

  JsonInfo.ofString() : this.of('String');

  JsonInfo.ofMap(Map<String, JsonInfo> objEntries) : this.of('Map', objects: objEntries);

  JsonInfo.ofEmptyMap() : this.of('Map');

  JsonInfo.ofList(List<JsonInfo> arrayEntries) : this.of('List', arrays: arrayEntries);

  JsonInfo.ofEmptyList() : this.of('List');

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is JsonInfo && runtimeType == other.runtimeType && json == other.json;

  @override
  int get hashCode => json.hashCode;

  Map get map {
    Map map = {'type': type};
    if (objects.isNotEmpty) map['objs'] = objects;
    if (arrays.isNotEmpty) {
      map['arrays'] = arrays.toSet().toList()..sort((o1, o2) => o1.type.compareTo(o2.type));
    }
    return map;
  }

  String get json {
    return jsonEncode(map, toEncodable: (o) {
      if (o is JsonInfo) {
        return o.map;
      }
      return o;
    });
  }

  String get md5 => hex.encode(crypt.md5.convert(utf8.encode(json)).bytes);
}