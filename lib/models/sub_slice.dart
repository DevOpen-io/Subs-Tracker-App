import 'dart:ui';

class SubSlice {
  final String name;
  final double amount;
  final Color color;
  final DateTime startDate;

  const SubSlice(this.name, this.amount, this.color , this.startDate);

  SubSlice copyWith({String? name, double? amount, Color? color, DateTime? startDate}) {
    return SubSlice(
      name ?? this.name,
      amount ?? this.amount,
      color ?? this.color,
      startDate ?? this.startDate
    );
  }
}
