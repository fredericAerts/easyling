import 'package:app/predicate_parser.dart';
import 'package:test/test.dart';

void main() {
  group("predicate_parser:", () {
    test('resolveNumericalRelationalPredicateWithGetters() evaluates explicit getter and returns result', () {
      expect(resolveNumericalRelationalPredicateWithGetters(new MyObject(), 'myGetter > 9'), true);
    });
  });
}

class MyObject {
  int get myGetter => 10;
}
