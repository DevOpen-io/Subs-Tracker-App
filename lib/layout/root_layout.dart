import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subs_tracker/config/router_config.dart';
import 'package:subs_tracker/models/sub_slice.dart';
import 'package:subs_tracker/providers/settings_controller.dart';
import 'package:subs_tracker/screens/onboarding_screen.dart';
import 'package:subs_tracker/widgets/add_subs_dialog.dart';
import 'package:subs_tracker/widgets/menu_bar.dart';

class RootLayout extends ConsumerWidget {
  const RootLayout({super.key, required this.child});

  final Widget
  child; // The widget (e.g., HomeScreen or TestScreen) that GoRouter will place here

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final currentPath = router.state.path;

    // Determine current tab index
    int selectedIndex = 0;
    if (currentPath == Routes.calendar.route) {
      selectedIndex = 1;
    } else if (currentPath == Routes.analytics.route) {
      selectedIndex = 2;
    } else if (currentPath == Routes.settings.route) {
      selectedIndex = 3;
    }
    final isFirstTime = ref
        .watch(settingsControllerProvider)
        .value
        ?.isFirstTime;

    return Scaffold(
      appBar: (isFirstTime ?? true)
          ? null
          : AppBar(
              title: const Text("Subs Tracker"),
              actions: [
                Visibility(
                  visible: currentPath == Routes.home.route,
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
      body: (isFirstTime ?? true) ? const OnboardingScreen() : child,
      bottomNavigationBar: (isFirstTime ?? true)
          ? null
          : BottomNavigationBar(
              currentIndex: selectedIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.go(Routes.home.route);
                    break;
                  case 1:
                    context.go(Routes.calendar.route);
                    break;
                  case 2:
                    context.go(Routes.analytics.route);
                    break;
                  case 3:
                    context.go(Routes.settings.route);
                    break;
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Subscriptions',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: 'Calendar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.analytics),
                  label: 'Analytics',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ), // Display the incoming page as content here.
    );
  }
}
