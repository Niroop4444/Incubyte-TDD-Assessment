class StringCalculator {
  final RegExp defaultDelimiter = RegExp(r'[,\n]');
  final RegExp customDelimiterRegEx = RegExp(r'^//(.+)\n([\s\S]*)$');

  int add(String input) {
    if (input.trim().isEmpty) return 0;

    RegExp activeDelimiter = defaultDelimiter;
    String numbersPart = input;

    final match = customDelimiterRegEx.firstMatch(input);

    if (match != null) {
      final delimiter = match.group(1)!;
      numbersPart = match.group(2)!;

      final escapedDelimiter = RegExp.escape(delimiter);
      activeDelimiter = RegExp('($escapedDelimiter|,|\n)');
    }

    return numbersPart
        .split(activeDelimiter)
        .where((s) => s.trim().isNotEmpty)
        .map(int.parse)
        .fold(0, (sum, n) => sum + n);
  }
}
