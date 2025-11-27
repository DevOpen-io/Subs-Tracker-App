import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subs_tracker/models/settings_view_model.dart';
import 'package:subs_tracker/models/sub_slice.dart';
import 'package:subs_tracker/providers/settings_controller.dart';
import 'package:subs_tracker/providers/subs_controller.dart';
import 'package:subs_tracker/widgets/add_subs_dialog.dart';
import 'package:subs_tracker/widgets/edit_subs_dialog.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slicesAsync = ref.watch(subsControllerProvider);
    final settingsAsync = ref.watch(settingsControllerProvider);

    return slicesAsync.when(
      data: (slices) => settingsAsync.when(
        data: (settings) => buildBody(slices, settings, context, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget buildBody(
    List<SubSlice> slices,
    SettingsViewModel settings,
    BuildContext context,
    WidgetRef ref,
  ) {
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

      final total = slices.fold<double>(0, (a, b) => a + b.monthlyAmount);
      final sortedSlices = List<SubSlice>.from(slices)
        ..sort((a, b) => b.monthlyAmount.compareTo(a.monthlyAmount));
      final mostExpensive = sortedSlices.first;

      return SafeArea(
        child: Column(
          children: [
            // Summary Card
            _SummaryCard(
              total: total,
              count: slices.length,
              mostExpensive: mostExpensive,
              currencySymbol: settings.currency.symbol,
            ),
            const SizedBox(height: 16),
            // Compact Subscription List
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: slices.length,
                itemBuilder: (context, index) {
                  final slice = slices[index];
                  return _CompactSubscriptionTile(
                    slice: slice,
                    index: index,
                    currencySymbol: settings.currency.symbol,
                  );
                },
              ),
            ),
          ],
        ),
      );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.total,
    required this.count,
    required this.mostExpensive,
    required this.currencySymbol,
  });

  final double total;
  final int count;
  final SubSlice mostExpensive;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Monthly Spending",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$currencySymbol${total.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "$count active",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  "Most expensive: ",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                ),
                Text(
                  "${mostExpensive.name} ($currencySymbol${mostExpensive.amount.toStringAsFixed(2)}/${mostExpensive.frequency.name.substring(0, 1)})",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactSubscriptionTile extends ConsumerWidget {
  const _CompactSubscriptionTile({
    required this.slice,
    required this.index,
    required this.currencySymbol,
  });

  final SubSlice slice;
  final int index;
  final String currencySymbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String frequencyShort;
    switch (slice.frequency) {
      case Frequency.daily:
        frequencyShort = "/day";
        break;
      case Frequency.weekly:
        frequencyShort = "/wk";
        break;
      case Frequency.monthly:
        frequencyShort = "/mo";
        break;
      case Frequency.yearly:
        frequencyShort = "/yr";
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Dismissible(
        key: Key('${slice.name}-$index'),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          return await showAdaptiveDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog.adaptive(
                title: const Text(
                  "Delete Subscription?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Text("Remove ${slice.name}?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Delete"),
                  ),
                ],
              );
            },
          );
        },
        onDismissed: (direction) {
          ref.read(subsControllerProvider.notifier).removeAt(index);
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.delete_outline,
            color: Colors.white,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            showAdaptiveDialog<void>(
              context: context,
              builder: (_) => EditSubsDialog(
                slice: slice,
                index: index,
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                _CompactSliceLeading(slice: slice),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        slice.name,
                        style: Theme.of(context).textTheme.labelLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Renews ${slice.startDate.month}/${slice.startDate.day} • ${slice.frequency.name}",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "$currencySymbol${slice.amount.toStringAsFixed(2)}$frequencyShort",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CompactSliceLeading extends StatelessWidget {
  const _CompactSliceLeading({required this.slice});

  final SubSlice slice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: slice.brand?.logo != null
            ? Colors.transparent
            : Color(slice.color),
        borderRadius: BorderRadius.circular(6),
      ),
      child: slice.brand?.logo != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(6),
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
