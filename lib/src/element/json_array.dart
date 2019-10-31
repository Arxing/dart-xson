import 'dart:core';

import 'package:xson/xson.dart';

class JsonArray extends JsonElement implements Iterable<JsonElement> {
  final List<JsonElement> _elements;

  JsonArray.empty() : _elements = [];

  JsonArray.capacity(int capacity) : _elements = List(capacity);

  @override
  JsonElement deepCopy() {
    if (_elements.isNotEmpty) {
      JsonArray result = JsonArray.capacity(_elements.length);
      _elements.forEach((o) => result.deepCopy());
      return result;
    }
    return JsonArray.empty();
  }

  @override
  bool any(bool Function(JsonElement element) test) => _elements.any(test);

  @override
  Iterable<R> cast<R>() => _elements.cast<R>();

  @override
  bool contains(Object element) => _elements.contains(element);

  @override
  JsonElement elementAt(int index) => _elements.elementAt(index);

  @override
  bool every(bool Function(JsonElement element) test) => _elements.every(test);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(JsonElement element) f) => _elements.expand(f);

  @override
  JsonElement get first => _elements.first;

  @override
  JsonElement firstWhere(bool Function(JsonElement element) test, {JsonElement Function() orElse}) => _elements.firstWhere(test);

  @override
  T fold<T>(T initialValue, T Function(T previousValue, JsonElement element) combine) => _elements.fold(initialValue, combine);

  @override
  Iterable<JsonElement> followedBy(Iterable<JsonElement> other) => _elements.followedBy(other);

  @override
  void forEach(void Function(JsonElement element) f) => _elements.forEach(f);

  @override
  bool get isEmpty => _elements.isEmpty;

  @override
  bool get isNotEmpty => _elements.isNotEmpty;

  @override
  Iterator<JsonElement> get iterator => _elements.iterator;

  @override
  String join([String separator = ""]) => _elements.join(separator);

  @override
  JsonElement get last => _elements.last;

  @override
  JsonElement lastWhere(bool Function(JsonElement element) test, {JsonElement Function() orElse}) => _elements.lastWhere(test);

  @override
  int get length => _elements.length;

  @override
  Iterable<T> map<T>(T Function(JsonElement e) f) => _elements.map<T>(f);

  @override
  JsonElement reduce(JsonElement Function(JsonElement value, JsonElement element) combine) => _elements.reduce(combine);

  @override
  JsonElement get single => _elements.single;

  @override
  JsonElement singleWhere(bool Function(JsonElement element) test, {JsonElement Function() orElse}) =>
      _elements.singleWhere(test);

  @override
  Iterable<JsonElement> skip(int count) => _elements.skip(count);

  @override
  Iterable<JsonElement> skipWhile(bool Function(JsonElement value) test) => _elements.skipWhile(test);

  @override
  Iterable<JsonElement> take(int count) => _elements.take(count);

  @override
  Iterable<JsonElement> takeWhile(bool Function(JsonElement value) test) => _elements.takeWhile(test);

  @override
  List<JsonElement> toList({bool growable = true}) => _elements.toList();

  @override
  Set<JsonElement> toSet() => _elements.toSet();

  @override
  Iterable<JsonElement> where(bool Function(JsonElement element) test) => _elements.where(test);

  @override
  Iterable<T> whereType<T>() => _elements.whereType<T>();

  List<JsonElement> get values => _elements;

  void add(JsonElement element) => _elements.add(element ?? JsonNull.INSTANCE);

  void addBool(bool val) => _elements.add(val == null ? JsonNull.INSTANCE : JsonPrimitive.ofBool(val));

  void addString(String val) => _elements.add(val == null ? JsonNull.INSTANCE : JsonPrimitive.ofString(val));

  void addNum(num val) => _elements.add(val == null ? JsonNull.INSTANCE : JsonPrimitive.ofNum(val));

  void addAll(JsonArray array) => _elements.addAll(array._elements);

  void set(int index, JsonElement element) => _elements[index] = element;

  void remove(JsonElement element) => _elements.remove(element);

  void removeAt(int index) => _elements.removeAt(index);

  JsonElement operator [](int index) => _elements[index];

  void operator []=(int index, JsonElement element) => _elements[index] = element;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is JsonArray && runtimeType == other.runtimeType && _elements == other._elements;

  @override
  int get hashCode => _elements.hashCode;
}
