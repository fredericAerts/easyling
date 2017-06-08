import 'package:app/file_io.dart';
import "package:test/test.dart";

void main() {
   group("file_IO:", () {
    test('fetchLines() returns type <List<String>>', () async {
      expect(await fetchLines('inputs.txt'), new isInstanceOf<List<String>>());
    });

    test('fetchLines() catches invalid filename error', () async {
      expect(() => fetchLines('foo.txt'), returnsNormally);
    });
  });
}
