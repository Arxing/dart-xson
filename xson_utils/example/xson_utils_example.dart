import '../lib/xson_utils.dart';

main() {
  registerPrimitiveTranslatorT<O, String>(t1);
  registerPrimitiveTranslatorT<O, int>(t2);
  var input = O(1000);
  var output = translateT<int>(input);
  print(output);
}

TypeTranslator<O, String> t1 = TypeTranslator((input) => "${input.i} 666");

TypeTranslator<O, int> t2 = TypeTranslator((input) => 9999);

class O {
  int i;
  O(this.i);
}

class P {}
