import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subs_tracker/providers/settings_controller.dart';

class AppStartup extends ConsumerStatefulWidget {
  const AppStartup({super.key , required this.child});

  final Widget child;

  @override
  ConsumerState<AppStartup> createState() => _AppStartupState();
}

class _AppStartupState extends ConsumerState<AppStartup> {
  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(settingsControllerProvider);
    return settingsAsync.when(
      data: (data) {
        return widget.child;
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => const Center(
        child: Text('Something went wrong'),
      ),
    );
  }
}