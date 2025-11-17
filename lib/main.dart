import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subs_tracker/config/router_config.dart';
import 'package:subs_tracker/providers/settings_controller.dart';
import 'package:subs_tracker/utils/app_theme.dart';
import 'package:subs_tracker/utils/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.instance.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsControllerProvider);
    final router = ref.watch(goRouterProvider);
    
    return settingsAsync.when(
      data: (settings) => MaterialApp.router(
        routerConfig: router,
        title: 'Subs Tracker',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: settings.theme,
      ),
      loading: () => const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (err, stack) => MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
