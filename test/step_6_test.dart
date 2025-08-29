import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_string_calculator/string_calculator.dart';

void main() {
  group("Step6. Numbers bigger than 1000 should be ignored", () {

    final calculator = StringCalculator();

    test('Ignore numbers more than 1000', () {
      expect(calculator.add("2,1001"), 2);
    });

    test("But if 1000, won't be ignored", () {
      expect(calculator.add("1000,2"), 1002);
    });

    test('More than 1000 considered 0, so adding up all comes 3', () {
      expect(calculator.add("1234,1002,3"), 3);
    });
  });
}