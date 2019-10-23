@deprecated
class JsonValueTransformer {
  static R parse<R>(dynamic v) {
    if (v == null) return null;
    Type actualType = v.runtimeType;
    Type expectType = R;
    dynamic result = v;
    switch (expectType) {
      case String:
        result = v.toString();
        break;
      case bool:
        switch (actualType) {
          case String:
            var s = v.toString().toLowerCase();
            result = s == "true" ? true : s == "false" ? false : throw "String($v) cannot parse to bool";
            break;
          case bool:
            result = v;
            break;
          case int:
          case double:
            throw "int or double cannot parse to bool";
        }
        break;
      case int:
        switch (actualType) {
          case String:
            result = int.parse(v.toString());
            break;
          case int:
            result = v;
            break;
          case bool:
          case double:
            throw "bool or double cannot parse to int";
        }
        break;
      case double:
        switch (actualType) {
          case String:
            result = double.parse(v.toString());
            break;
          case double:
            result = v;
            break;
          case bool:
            throw "bool cannot parse to double";
          case int:
            result = (v as int).toDouble();
            break;
        }
        break;
    }
    return result as R;
  }
}

List<Type> _primitiveTypes = [int, double, bool, String];

@deprecated
bool isPrimitive(Type type) => type == null ? false : _primitiveTypes.any((o) => o == type);

@deprecated
bool isNotPrimitive(Type type) => type == null ? false : !isPrimitive(type);

@deprecated
bool isList(Type type) => type == null ? false : type.toString().startsWith("List<");

@deprecated
bool isMap(Type type) => type == null ? false : type.toString().startsWith("Map<");
