import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:subs_tracker/models/sub_slice.dart';
import 'package:subs_tracker/utils/color_utils.dart';



const slices = <SubSlice>[
  SubSlice('Netflix', 99, Colors.red),
  SubSlice('Spotify', 39, Colors.green),
  SubSlice('YouTube', 57, Colors.blue),
  SubSlice('iCloud', 26, Colors.lightBlueAccent),
];

class SubsPie extends StatefulWidget {
  const SubsPie({super.key});

  @override
  State<SubsPie> createState() => _SubsPieState();
}

class _SubsPieState extends State<SubsPie> {
  int? touchedIndex;

  double get total => slices.fold(0, (a, b) => a + b.amount);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.3,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 0,
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  setState(() {
                    touchedIndex =
                        response?.touchedSection?.touchedSectionIndex;
                  });
                },
              ),
              sections: List.generate(slices.length, (i) {
                final s = slices[i];
                final isTouched = i == touchedIndex;
                final percent = total == 0 ? 0 : (s.amount / total) * 100;
                return PieChartSectionData(
                  color: s.color,
                  value: s.amount,
                  title: '${percent.toStringAsFixed(2)}%',
                  titleStyle: TextStyle(
                    fontSize: isTouched ? 16 : 13,
                    fontWeight: FontWeight.w800,
                    color: darkerOf(s.color , 0.4),
                  ),
                  radius: isTouched ? 150 : 130,
                  badgeWidget: isTouched ? _Badge(label: s.name) : null,
                );
              }),
            ),
            duration: const Duration(milliseconds: 100),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: slices.map((s) {
            final percent = total == 0 ? 0 : (s.amount / total) * 100;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: s.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '${s.name} · ${s.amount.toStringAsFixed(0)} ₺ (${percent.toStringAsFixed(2)}%)',
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(blurRadius: 6, offset: Offset(0, 2), spreadRadius: -1),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(label, style: Theme.of(context).textTheme.labelMedium),
      ),
    );
  }
}
