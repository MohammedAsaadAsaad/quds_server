// import 'package:quds_server/quds_server.dart';
import 'package:quds_server/quds_server.dart';
import 'package:test/test.dart';

void main() {
  group('Validation Tests', () {
    test('Commons', () {
      expect(Required().validate('some value', 1), null);
      expect(Min(5).validate('some value', null), null);
      expect(Max(10).validate('some value', null), null);
      expect(Max(10).min(5).validate('some value', null), null);
    });

    test('Numbers', () {
      expect(IsInteger().validate('some value', 1), null);
      expect(IsPositiveInteger().validate('some value', 1), null);
    });

    test('Lists', () {
      expect(IsListOfType<int?>().validate('some value', [null, -5, 4]), null);
    });
  });
}
