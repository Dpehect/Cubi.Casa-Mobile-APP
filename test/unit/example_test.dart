import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Counter Tests', () {
    test('Counter increments', () {
      int counter = 0;
      counter++;
      expect(counter, 1);
    });

    test('Counter decrements', () {
      int counter = 1;
      counter--;
      expect(counter, 0);
    });
  });
}
