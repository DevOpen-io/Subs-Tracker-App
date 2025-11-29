import 'package:flutter_test/flutter_test.dart';
import 'package:subs_tracker/models/sub_slice.dart';

void main() {
  group('SubSlice', () {
    test('monthlyAmount calculates correctly for Daily', () {
      final slice = SubSlice(
        name: 'Test',
        amount: 10,
        color: 0,
        startDate: DateTime.now(),
        frequency: Frequency.daily,
      );
      expect(slice.monthlyAmount, 300); // 10 * 30
    });

    test('monthlyAmount calculates correctly for Weekly', () {
      final slice = SubSlice(
        name: 'Test',
        amount: 10,
        color: 0,
        startDate: DateTime.now(),
        frequency: Frequency.weekly,
      );
      expect(slice.monthlyAmount, 43.3); // 10 * 4.33
    });

    test('monthlyAmount calculates correctly for Monthly', () {
      final slice = SubSlice(
        name: 'Test',
        amount: 10,
        color: 0,
        startDate: DateTime.now(),
        frequency: Frequency.monthly,
      );
      expect(slice.monthlyAmount, 10);
    });

    test('monthlyAmount calculates correctly for Yearly', () {
      final slice = SubSlice(
        name: 'Test',
        amount: 120,
        color: 0,
        startDate: DateTime.now(),
        frequency: Frequency.yearly,
      );
      expect(slice.monthlyAmount, 10); // 120 / 12
    });

    test('default frequency is Monthly', () {
      final slice = SubSlice(
        name: 'Test',
        amount: 10,
        color: 0,
        startDate: DateTime.now(),
      );
      expect(slice.frequency, Frequency.monthly);
    });
  });
}
