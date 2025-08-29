import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_string_calculator/string_calculator.dart';

void main() {

  group("Step2. Add any amount of comma separated string of numbers", () {
    late StringCalculator calculator;

    setUp(() {
      calculator = StringCalculator();
    });

    test('If more than 2 numbers are passed it should be added', () {
      expect(calculator.add('1,2,3'), 6);
    });

    test('Even if there are 10 numbers are passed it should be added', () {
      expect(calculator.add('1,2,3,4,5,6,7,8,9,0'), 45);
    });

  });
}