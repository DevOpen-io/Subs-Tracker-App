import 'dart:ui';

class SubSlice {
  final String name;
  final double amount;
  final Color color;

  const SubSlice(this.name, this.amount, this.color);

  SubSlice copyWith({String? name, double? amount, Color? color}) {
    return SubSlice(
      name ?? this.name,
      amount ?? this.amount,
      color ?? this.color,
    );
  }
}
