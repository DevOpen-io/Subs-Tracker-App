import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subs_tracker/providers/settings_slice_provider.dart';
import 'package:subs_tracker/screens/home_screen.dart';
import 'package:subs_tracker/utils/app_theme.dart';
import 'package:subs_tracker/utils/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.instance.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(settingsSliceProvider).theme;
    return MaterialApp(
      title: 'Subs Tracker',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeData,
      home: HomeScreen(),
    );
  }
}
