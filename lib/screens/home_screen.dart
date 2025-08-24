import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subs_tracker/models/sub_slice.dart';
import 'package:subs_tracker/providers/subs_controller.dart';
import 'package:subs_tracker/widgets/add_subs_dialog.dart';
import 'package:subs_tracker/widgets/menu_bar.dart';
import 'package:subs_tracker/widgets/pie_chart.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final slicesAsync = ref.watch(subsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Subs Tracker"), actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () async {
            await showAdaptiveDialog<SubSlice>(
              context: context,
              builder: (_) => const AddSubsDialog(),
            );
          },
        ),
      ]),
      drawer: SidebarMenu(),
      body: switch (slicesAsync) {
        AsyncLoading<List<SubSlice>>() => CircularProgressIndicator.adaptive(),
        AsyncData<List<SubSlice>>(:final value) => _buildBody(value),
        AsyncError<List<SubSlice>>(:final error) => Center(
          child: Text('Error: $error'),
        ),
      },
    );
  }

  Widget _buildBody(List<SubSlice> slices) {
    if (slices.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Subscription Data Not Added Yet.",
            ),
          ),
          const SizedBox(height: 12),
          TextButton(onPressed: () {
            showAdaptiveDialog<SubSlice>(
              context: context,
              builder: (_) => const AddSubsDialog(),
            );
          }, child: const Text("Add Subscription"))
        ],
      );
    }
    return SafeArea(
      child: Column(
        children: [
          SubsPie(),
          const SizedBox(height: 12),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              padding: const EdgeInsets.all(8),
              itemCount: slices.length,
              itemBuilder: (context, index) {
                final s = slices[index];
                final percent =
                    slices.fold<double>(0, (a, b) => a + b.amount) == 0
                    ? 0
                    : (s.amount /
                              slices.fold<double>(0, (a, b) => a + b.amount)) *
                          100;

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.all(0),
                  child: ListTile(
                    minTileHeight: 60,
                    contentPadding: const EdgeInsets.all(0),
                    leading: Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: Color(s.color),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      width: 40,
                      height: 60,
                      margin: const EdgeInsets.all(0),
                      child: Center(
                        child: Text(
                          s.name[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    title: Text(s.name),
                    subtitle: Text(
                      "${s.amount.toStringAsFixed(2)} ₺ · ${percent.toStringAsFixed(1)}% · ${s.startDate.month}/${s.startDate.day}/${s.startDate.year}",
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: Theme.of(context).colorScheme.error,
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
                                        .read(subsControllerProvider.notifier)
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
      ),
    );
  }
}
