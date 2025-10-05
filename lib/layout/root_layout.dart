import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subs_tracker/config/router_config.dart';
import 'package:subs_tracker/models/sub_slice.dart';
import 'package:subs_tracker/widgets/add_subs_dialog.dart';
import 'package:subs_tracker/widgets/menu_bar.dart';

class RootLayout extends ConsumerWidget {
  const RootLayout({super.key, required this.child});

  final Widget
  child; // The widget (e.g., HomeScreen or TestScreen) that GoRouter will place here

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Subs Tracker"),
        actions: [
          Visibility(
            visible: router.state.path == Routes.home.route,
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                await showAdaptiveDialog<SubSlice>(
                  context: context,
                  builder: (_) => const AddSubsDialog(),
                );
              },
            ),
          ),
        ],
      ),
      drawer: const SidebarMenu(),
      body: child, // Display the incoming page as content here.
    );
  }
}
