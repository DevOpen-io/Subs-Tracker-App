import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subs_tracker/providers/settings_slice_provider.dart';
import 'package:subs_tracker/providers/sub_slice_provider.dart';
import 'package:subs_tracker/widgets/pie_chart.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsSliceProvider).theme;
    return Consumer(
      builder: (context, ref, child) {
        final slices = ref.watch(subSliceProvider);

        if (slices.isEmpty) {
          return const Center(
            child: Text(
              "Subscription Data Not Added Yet.",
              style: TextStyle(color: Colors.grey),
            ),
          );
        }
        return Column(
          children: [
            SubsPie(),
            const SizedBox(height: 12),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: slices.length,
                itemBuilder: (context, index) {
                  final s = slices[index];
                  final percent =
                      slices.fold<double>(0, (a, b) => a + b.amount) == 0
                      ? 0
                      : (s.amount /
                                slices.fold<double>(
                                  0,
                                  (a, b) => a + b.amount,
                                )) *
                            100;

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: s.color,
                        child: Text(
                          s.name[0].toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(s.name),
                      subtitle: Text(
                        "${s.amount.toStringAsFixed(2)} ₺ · ${percent.toStringAsFixed(1)}% · ${s.startDate.month}/${s.startDate.day}/${s.startDate.year}",
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: theme == ThemeMode.dark
                              ? Colors.red[900]
                              : Colors.red,
                        ),
                        onPressed: () {
                          showAdaptiveDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog.adaptive(
                                title: const Text(
                                  "Are You Sure Delete ?",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      ref
                                          .read(subSliceProvider.notifier)
                                          .removeAt(index);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Delete"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
