import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subs_tracker/models/sub_slice.dart';
import 'package:subs_tracker/providers/subs_controller.dart';
import 'package:subs_tracker/widgets/add_subs_dialog.dart';
import 'package:subs_tracker/widgets/pie_chart.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slicesAsync = ref.watch(subsControllerProvider);

    Widget buildBody(List<SubSlice> slices) {
      if (slices.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: Text("Subscription Data Not Added Yet.")),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                showAdaptiveDialog<SubSlice>(
                  context: context,
                  builder: (_) => const AddSubsDialog(),
                );
              },
              child: const Text("Add Subscription"),
            ),
          ],
        );
      }

      final total = slices.fold<double>(0, (a, b) => a + b.amount);

      return SafeArea(
        child: Column(
          children: [
            const SubsPie(),
            const SizedBox(height: 12),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                padding: const EdgeInsets.all(8),
                itemCount: slices.length,
                itemBuilder: (context, index) {
                  final slice = slices[index];
                  final percent = total == 0 ? 0 : (slice.amount / total) * 100;

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.all(0),
                    child: ListTile(
                      minTileHeight: 60,
                      contentPadding: const EdgeInsets.all(0),
                      leading: _SliceLeading(slice: slice),
                      title: Text(slice.name),
                      subtitle: Text(
                        "${slice.amount.toStringAsFixed(2)} ₺ · ${percent.toStringAsFixed(1)}% · ${slice.startDate.month}/${slice.startDate.day}/${slice.startDate.year}",
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

    return switch (slicesAsync) {
      AsyncLoading<List<SubSlice>>() => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      AsyncData<List<SubSlice>>(:final value) => buildBody(value),
      AsyncError<List<SubSlice>>(:final error) => Center(
        child: Text("Error: $error"),
      ),
    };
  }
}

class SubAvatar extends StatelessWidget {
  const SubAvatar({super.key, required this.s});

  final SubSlice s;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        s.name[0].toUpperCase(),
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class _SliceLeading extends StatelessWidget {
  const _SliceLeading({required this.slice});

  final SubSlice slice;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: slice.brand?.logo != null
            ? Colors.transparent
            : Color(slice.color),
        borderRadius: BorderRadius.only(
          topLeft: borderRadius.topLeft,
          bottomLeft: borderRadius.bottomLeft,
        ),
      ),
      width: 60,
      height: 60,
      margin: EdgeInsets.zero,
      child: slice.brand?.logo != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: slice.brand!.logo!,
                fit: BoxFit.contain,
                placeholder: (_, __) => const _SliceLogoPlaceholder(),
                errorWidget: (_, __, ___) => SubAvatar(s: slice),
              ),
            )
          : SubAvatar(s: slice),
    );
  }
}

class _SliceLogoPlaceholder extends StatelessWidget {
  const _SliceLogoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
