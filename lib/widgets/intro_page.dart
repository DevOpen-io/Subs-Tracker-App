import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subs_tracker/models/settings_view_model.dart';
import 'package:subs_tracker/providers/settings_controller.dart';

class IntroPage extends HookConsumerWidget {
  const IntroPage({
    super.key,
    required this.selectedCurrency,
    required this.tmpThemeMode,
  });

  final ValueNotifier<Currency> selectedCurrency;
  final ValueNotifier<ThemeMode> tmpThemeMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode =
        ref.watch(settingsControllerProvider).value?.theme ?? ThemeMode.system;
    final isDark = themeMode == ThemeMode.dark;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32.0, 60.0, 32.0, 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.subscriptions_rounded,
                size: 80,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Welcome to\nSubs Tracker',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Track all your subscriptions in one place.\nNever miss a payment again.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              child: DropdownButton<Currency>(
                value: selectedCurrency.value,
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down_rounded),
                borderRadius: BorderRadius.circular(20),
                items: Currency.values.map((Currency currency) {
                  return DropdownMenuItem<Currency>(
                    value: currency,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currency.symbol,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(currency.label),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (Currency? newValue) {
                  if (newValue != null) {
                    selectedCurrency.value = newValue;
                  }
                },
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.light_mode_rounded,
                    size: 20,
                    color: !isDark ? Colors.orange : Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  Switch(
                    value: isDark,
                    onChanged: (value) {
                      ref
                          .read(settingsControllerProvider.notifier)
                          .updateTheme(
                            value ? ThemeMode.dark : ThemeMode.light,
                          );

                      tmpThemeMode.value = value
                          ? ThemeMode.dark
                          : ThemeMode.light;
                      debugPrint("theme ${tmpThemeMode.value}");
                    },
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.dark_mode_rounded,
                    size: 20,
                    color: isDark ? Colors.blue : Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
