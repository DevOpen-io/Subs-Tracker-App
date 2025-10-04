import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:subs_tracker/layout/root_layout.dart';
import 'package:subs_tracker/screens/home_screen.dart';
import 'package:subs_tracker/screens/test_screen.dart';
part 'router_config.g.dart';

enum Routes {
  home,
  test;

  String get name => toString().replaceAll('Routes.', '');
  String get route => '/$name';
}

@riverpod
GoRouter goRouter(Ref ref) => GoRouter(
  initialLocation: Routes.home.route,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return RootLayout(child: child);
      },
      routes: [
        GoRoute(
          path: Routes.home.route,
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
        GoRoute(
          path: Routes.test.route,
          builder: (BuildContext context, GoRouterState state) =>
              const TestScreen(),
        ),
      ],
    ),
  ],
);
