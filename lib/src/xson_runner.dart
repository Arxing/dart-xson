import 'dart:convert';

class XsonRunner {

  void run(String source) {
    dynamic json = jsonDecode(source, reviver: _onNode);
  }

  Object _onNode(dynamic key, dynamic value) {
    print('key=$key(${key.runtimeType}), value=$value(${value.runtimeType})');
    return 100;
  }
}
