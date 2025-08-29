import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_string_calculator/string_calculator.dart';

void main() {

  group("Step 1. Tests", () {
    late StringCalculator calculator;

    setUp(() {
      calculator = StringCalculator();
    });

    test("Empty string gives output 0", () {
      expect(calculator.add(""), 0);
    });

    test("Single number return same", () {
      expect(calculator.add('1'), 1);
    });

    test("Only one double digit number return same", () {
      expect(calculator.add('45'), 45);
    });

    test("Numbers separated by comma return the addition of all", () {
      expect(calculator.add("1,5"), 6);
    });

    test('If more than 2 numbers are passed throws error', () {
      expect(() => calculator.add('1,2,3'), throwsFormatException);
    });

    test("If number is starting with comma, it throws exception", () {
      expect(() => calculator.add(",1,5"), throwsException);
    });

    test("If number is ended by a comma, it throws exception", () {
      expect(() => calculator.add("1,5,"), throwsException);
    });

  });
}