# tdd_string_calculator

A Dart/Flutter-based implementation of the classic String Calculator Kata, following Test-Driven Development (TDD) principles.

This repository walks through the various steps of the String Calculator Kata, with corresponding tests to ensure correctness and handle edge cases effectively.

📚 Problem Statement
Implement a calculator that takes a string of numbers separated by delimiters and returns their sum, following these progressive steps:

1️⃣ Create a simple String calculator with a method signature like this: input should be a string of comma-separated numbers and output an integer, sum of the numbers. For example :- -> Input: “”, Output: 0 -> Input: “1”, Output: 1 -> Input: “1,5”, Output: 6

2️⃣ Allow the add method to handle any amount of numbers.

3️⃣ Allow the add method to handle new lines between numbers (instead of commas). ("1\n2,3" should return 6)

4️⃣ Support different delimiters: -> To change the delimiter, the beginning of the string will contain a separate line that looks like this: "//[delimiter]\n[numbers…]". For example, "//;\n1;2" where the delimiter is ";" should return 3.

5️⃣ Calling add with a negative number will throw an exception: "negative numbers not allowed <negative_number>".

6️⃣ Numbers bigger than 1000 should be ignored, so adding 2 + 1001 = 2

7️⃣ Delimiters can be of any length with the following format: “//[delimiter]\n” for example: “//[***]\n1***2***3” should return 6

8️⃣ Allow multiple delimiters like this: “//[delim1][delim2]\n” for example “//[*][%]\n1*2%3” should return 6.

9️⃣ handle multiple delimiters with length longer than one char

Prerequisites
Dart SDK or Flutter SDK
A code editor

📁 Folder strucuture

├── lib/ 
│ 
├── string_calculator.dart # Main calculator logic 
| 
├── main.dart # Minimal UI 
├── test/ 
│ 
├── step1_return_zero.dart 
│ 
├── step2_return_number.dart 
│ 
├── ... 
├── pubspec.yaml

The main.dart file consits of the minimal UI of the TextFormField, ElevatedButton & RichText

Values are entered through a TextFormField, and when the ElevatedButton is pressed, the input is passed to the add method defined in string_calculator.dart. The method performs the calculation and returns the result, which is then stored in the additionResult variable and displayed using a RichText widget.

Install Dependencies
flutter pub get

Run all tests
flutter test

To run individual test
flutter test test/step1_add_string_of_comma_separated_numbers.dart

🧑‍💻 Implementation Overview
To accomplish this kata:

I created a minimal Flutter UI in the main.dart file using a TextFormField for input, an ElevatedButton to trigger the operation, and a RichText widget to display the result.
I encapsulated the core logic in a separate class called StringCalculator, following the Single Responsibility Principle.
The class contains an add method that performs all the parsing and calculation.
To manage different kinds of delimiters, I introduced two regular expressions: -> commaNewLineRegEx to handle default delimiters (, and \n) -> customCommaRegEx to detect and apply custom delimiters from input (e.g., //;\n1;2)

✅ Step 1: Basic Comma-Separated Inputs

Used split(',') to separate the numbers.
Parsed each number with int.parse.
Handled empty string by returning 0.
Threw a FormatException for more than two numbers or if input starts/ends with a comma.

✅ Step 2: Support Any Amount of Numbers

Removed the check that limited input to only two numbers.

// Removed this check:
// if (numbers.length > 2) {
//   throw FormatException("Only up to 2 numbers are allowed");
// }

✅ Step 3: Support Newline as Delimiter

Introduced a regular expression commaNewLineRegEx = RegExp(r'[,\n]') to handle both comma and newline.
Updated split(delimiter) to use the combined regex instead of just comma.
Enabled inputs like "1\n2" or "1\n2,3".

✅ Step 4: Support Custom Delimiters

Introduced customCommaRegEx = RegExp(r'^//(.+)\n(.*)$') to detect custom delimiters.
If custom delimiter syntax is matched, used that character as the delimiter instead of default regex.
Escaped custom delimiters with RegExp.escape(customDelimiter) for safety.
Updated logic to extract the actual number section from the input.

✅ Step 5: Handle Negative Numbers

After parsing numbers, filtered negative values using: final negatives = numbers.where((n) => n < 0).toList();
If any negative numbers were found, threw a FormatException listing all of them:
if (negatives.isNotEmpty) {
  throw FormatException("negative numbers not allowed: ${negatives.join(',')}");
}

✅ Step 6: Ignore Numbers > 1000

Applied a filter before summing to exclude numbers greater than 1000:

return numbers.where((currentValue) => currentValue <= 1000).fold(0, (initialValue, currentValue) => initialValue + currentValue);

✅ Step 7: Allow Delimiters of Any Length

Enhanced the logic to support delimiters wrapped in square brackets, such as `//[***]\n1***2***3.`
To correctly extract the actual delimiter (without brackets), added this check:

```
if (delimiter.startsWith('[') && delimiter.endsWith(']')) {
  delimiter = delimiter.substring(1, delimiter.length - 1); // remove [ ]
}
```

This ensures that `[***]` becomes `***` before being passed to the regex for splitting.
As a result, delimiters of arbitrary length (e.g., ***, %%, ###) are handled correctly during parsing.

✅ Step 8: Allow Multiple Delimiters

To achieve this, used a regex to capture all delimiters wrapped in square brackets:

```
final bracketRegEx = RegExp(r'\[(.+?)\]');
final bracketMatches = bracketRegEx.allMatches(delimiterSection);

if (bracketMatches.isNotEmpty) {
  delimiters = bracketMatches.map((m) => m.group(1)!).toList();
} else {
  delimiters = [delimiterSection]; // single delimiter
}
```

This way, delimiters such as `*`, `%`, `##`, `***`, etc., can all coexist.
Then joined them into a single regex for splitting. Now the calculator correctly supports multiple delimiters of varying lengths in a single input string.

✅ Step 9: Handle Multiple Delimiters with Length Longer Than One Character

* Updated parsing to allow multiple delimiters of arbitrary length (e.g., //[***][%%]\n1***2%%3).

* Making the delimiter extraction regex r'\[(.+?)\]' handle any length, instead of only assuming single-character delimiters.

* And building delimiters list with .map((m) => m.group(1)!).

🧪 Test Coverage by Feature

✅ Step 1: Handling Basic Comma-Separated Inputs (`step_1_test.dart`)

Implemented unit tests to verify that the add method correctly handles empty strings, single numbers, and comma-separated values. It also checks for invalid inputs like inputs starting or ending with a comma, or passing more than two numbers, which should throw appropriate exceptions.

✅ Step 2: Handling Any Number of Comma-Separated Inputs(`step_2_test.dart`)

Added tests to ensure the add method can handle any number of comma-separated numeric values. This includes inputs with more than two numbers (e.g., 1,2,3) and even longer sequences (e.g., ten numbers), confirming that all are summed correctly without throwing exceptions.

✅ Step 3: Supporting New Line as a Delimiter(`step_3_test.dart`)

Enhanced the add method to support new lines (\n) as valid delimiters between numbers. Tests verify that combinations of commas and new lines (e.g., 1\n2, 1\n3,5, 1,3\n5) are handled correctly, and the sum is computed as expected.

✅ Step 4: Supporting Custom Delimiters (`step_4_test.dart`)

Enhanced the calculator to handle custom delimiters defined in the format //<delimiter>\n<numbers>. Tests verify the correct addition using various custom delimiters like ;, #, and -. It also ensures that incorrectly formatted inputs (e.g., ending with a delimiter) throw a FormatException.

✅ Step 5: Handling Negative Numbers (`step_5_test.dart`)

Implemented logic to detect negative numbers and throw a FormatException. If the input includes one or more negative values (including with custom delimiters), an exception is raised with all negative numbers listed in the error message. A passing test case is also included to ensure valid inputs without negatives still return the correct sum.

✅ Step 6: Ignoring Numbers Greater Than 1000 (`step_6_test.dart`)

Enhanced the logic to ignore any number greater than 1000 during summation. These numbers are treated as zero and do not affect the result. Tests confirm that 1000 is still included, while numbers like 1001 or 1234 are excluded from the total.

✅ Step 7: Delimiters of Any Length (step_7_test.dart)

Enhanced the logic to allow custom delimiters of any length using the format //[delimiter]\n.
This supports delimiters like *** or abc. Tests confirm correct summation with multi-character delimiters, ignoring numbers >1000, handling single inputs, and still throwing exceptions for negatives.

✅ Step 8: Multiple Delimiters (step_8_test.dart)

Extended the logic to support multiple custom delimiters using the format //[delim1][delim2]\n.
This allows combinations like [*][%] or even longer delimiters mixed together. Tests confirm correct summation across different delimiters, ignoring numbers >1000, handling single inputs, and still throwing exceptions for negatives.

✅ Step 9: Multiple Delimiters of Any Length (step_9_test.dart)

Enhanced the parser to handle multiple custom delimiters of varying lengths (e.g., [*], [%%], [###]).
The logic now correctly splits numbers using all defined delimiters, regardless of length. Tests verify summation with different delimiters, ignoring numbers >1000, proper handling of single numbers, and throwing exceptions for negatives.

<img width="320" height="718" alt="step_8_1" src="https://github.com/user-attachments/assets/3cab9ba2-e3e7-43fe-960e-1d89f4d85950" />
<img width="320" height="718" alt="step_7_2" src="https://github.com/user-attachments/assets/4ea505f7-43b1-42a4-ae08-b3867f4244bf" />
<img width="320" height="718" alt="step_7_1" src="https://github.com/user-attachments/assets/3637b67e-9f09-4650-839b-4948bede53c4" />
<img width="320" height="718" alt="step_6_2" src="https://github.com/user-attachments/assets/af12fd5a-61cb-40ff-bbcc-e191a08506bc" />
<img width="320" height="718" alt="step_6_1" src="https://github.com/user-attachments/assets/34525584-1c53-4a77-adcc-8ec9aa9ef24e" />
<img width="320" height="718" alt="step_4_5" src="https://github.com/user-attachments/assets/e80945ef-ddde-40ce-a1e1-c104403f796c" />
<img width="320" height="718" alt="step_4_4" src="https://github.com/user-attachments/assets/be2be711-f3d9-45ef-8e6d-52dbe2debe83" />
<img width="320" height="718" alt="step_4_3" src="https://github.com/user-attachments/assets/9b3f9ee0-f7c7-4002-9f54-95892712ea43" />
<img width="320" height="718" alt="step_4_2" src="https://github.com/user-attachments/assets/094d8138-fedb-446f-a8f7-d06635008f14" />
<img width="320" height="718" alt="step_4_1" src="https://github.com/user-attachments/assets/4c8ce9a8-3703-4dfe-89cc-efa96c23e336" />
<img width="320" height="718" alt="step_3_2" src="https://github.com/user-attachments/assets/03d60b6f-1c17-4c34-a65d-8dc076685094" />
<img width="320" height="718" alt="step_3_1" src="https://github.com/user-attachments/assets/c2093007-4ba4-4ad2-9894-f33d91f5cc9c" />
<img width="320" height="718" alt="step_2_2" src="https://github.com/user-attachments/assets/3b9039ee-cb7c-48d7-9a41-9bcf93babf8e" />
<img width="320" height="718" alt="step_2_1" src="https://github.com/user-attachments/assets/9a08049a-dea5-4cea-bcad-1a57fa9f03a0" />
<img width="320" height="718" alt="step_1_2" src="https://github.com/user-attachments/assets/ed1ffefa-7aed-4f45-829f-057939d66d57" />
<img width="320" height="718" alt="step_1_1" src="https://github.com/user-attachments/assets/fae01fc4-669e-4b95-b049-7e3b9a682773" />
<img width="320" height="718" alt="step_9_1" src="https://github.com/user-attachments/assets/9e257e8a-0fbb-4238-a12d-fd50cb8a4454" />

