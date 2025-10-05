import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subs_tracker/providers/ui_providers.dart';
import 'package:subs_tracker/widgets/menu_bar.dart';

class RootLayout extends ConsumerWidget {
  const RootLayout({super.key, required this.child});

  final Widget
  child; // The widget (e.g., HomeScreen or TestScreen) that GoRouter will place here

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarActions = ref.watch(appBarActionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Subs Tracker"),
        actions: appBarActions,
      ),
      drawer: const SidebarMenu(),
      body: child, // Display the incoming page as content here.
    );
  }
}
