import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subs_tracker/models/settings_view_model.dart';
import 'package:subs_tracker/providers/settings_controller.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsControllerProvider);

    return settingsAsync.when(
      data: (settings) => _buildSettings(context, settings, ref),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildSettings(
    BuildContext context,
    SettingsViewModel settings,
    WidgetRef ref,
  ) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "settings.title",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ).tr(),
          const SizedBox(height: 24),
          // Theme Section
          _SettingsSection(
            title: "settings.appearance".tr(),
            children: [
              _SettingsTile(
                title: "settings.theme".tr(),
                subtitle: _getThemeLabel(settings.theme).tr(),
                onTap: () => _showThemeBottomSheet(context, settings, ref),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Currency Section
          _SettingsSection(
            title: "settings.currency".tr(),
            children: [
              _SettingsTile(
                title: "settings.currency_unit".tr(),
                subtitle:
                    "${settings.currency.label} (${settings.currency.symbol})",
                onTap: () =>
                    _showCurrencyBottomSheet(context, settings, ref),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Language Section
          _SettingsSection(
            title: "settings.language".tr(),
            children: [
              _SettingsTile(
                title: "settings.language".tr(),
                subtitle: context.locale.languageCode == 'en'
                    ? 'English'
                    : 'Türkçe',
                onTap: () => _showLanguageBottomSheet(context, ref),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // About Section
          _SettingsSection(
            title: "settings.about".tr(),
            children: [
              _SettingsTile(
                title: "settings.version".tr(),
                subtitle: "1.0.0",
                onTap: null,
              ),
              _SettingsTile(
                title: "settings.app_name".tr(),
                subtitle: "SubZilla",
                onTap: null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getThemeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return "settings.light";
      case ThemeMode.dark:
        return "settings.dark";
      case ThemeMode.system:
        return "settings.system";
    }
  }

  void _showThemeBottomSheet(
    BuildContext context,
    SettingsViewModel settings,
    WidgetRef ref,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "settings.select_theme".tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              ...[ThemeMode.light, ThemeMode.dark, ThemeMode.system]
                  .map((mode) => _ThemeOption(
                        label: _getThemeLabel(mode).tr(),
                        isSelected: settings.theme == mode,
                        onTap: () {
                          ref
                              .read(settingsControllerProvider.notifier)
                              .updateTheme(mode);
                          Navigator.pop(context);
                        },
                      )),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showCurrencyBottomSheet(
    BuildContext context,
    SettingsViewModel settings,
    WidgetRef ref,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "settings.select_currency".tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: Currency.values
                      .map((currency) => _CurrencyOption(
                            label: currency.label,
                            symbol: currency.symbol,
                            isSelected: settings.currency == currency,
                            onTap: () {
                              ref
                                  .read(settingsControllerProvider.notifier)
                                  .updateCurrency(currency);
                              Navigator.pop(context);
                            },
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
  void _showLanguageBottomSheet(
    BuildContext context,
    WidgetRef ref,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "settings.select_language".tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              _LanguageOption(
                label: "English",
                isSelected: context.locale.languageCode == 'en',
                onTap: () {
                  context.setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
              _LanguageOption(
                label: "Türkçe",
                isSelected: context.locale.languageCode == 'tr',
                onTap: () {
                  context.setLocale(const Locale('tr'));
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
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
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: onTap != null
            ? Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              )
            : null,
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      leading: isSelected
          ? Icon(Icons.radio_button_checked,
              color: Theme.of(context).primaryColor)
          : const Icon(Icons.radio_button_unchecked),
      onTap: onTap,
    );
  }
}

class _CurrencyOption extends StatelessWidget {
  const _CurrencyOption({
    required this.label,
    required this.symbol,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String symbol;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      subtitle: Text(symbol),
      leading: isSelected
          ? Icon(Icons.radio_button_checked,
              color: Theme.of(context).primaryColor)
          : const Icon(Icons.radio_button_unchecked),
      onTap: onTap,
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      leading: isSelected
          ? Icon(Icons.radio_button_checked,
              color: Theme.of(context).primaryColor)
          : const Icon(Icons.radio_button_unchecked),
      onTap: onTap,
    );
  }
}
