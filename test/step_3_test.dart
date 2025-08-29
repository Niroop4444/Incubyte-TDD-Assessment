import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_string_calculator/string_calculator.dart';

void main() {

  group("Step3. Add method to handle new lines between numbers (instead of commas)", () {
    late StringCalculator calculator;

    setUp(() {
      calculator = StringCalculator();
    });

    test("Even if a new line is present instead of comma between numbers, still addition should happen between the two", () {
      expect(calculator.add("1\n2"), 3);
    });

    test("Even if a number if present after a new line & a after comma, still addition should happen between the two", () {
      expect(calculator.add("1\n3,5"), 9);
    });

    test("If a comma is present before the new line, still addition should happen between the two", () {
      expect(calculator.add("1,3\n5"), 9);
    });
  });
}