import 'package:app/shapes_parser.dart';
import 'package:test/test.dart';

import 'package:app/shapes.dart';

void main() {
  group("shapes_parser:", () {
    test('parseShapeFromLine(\"rectangle 3 8\") returns instance of Rectangle', () {
      expect(parseShapeFromLine('rectangle 3 8'), new isInstanceOf<Rectangle>());
    });
  });
}
