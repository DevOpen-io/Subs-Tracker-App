import 'package:flutter/material.dart';
import 'package:subs_tracker/providers/settings_slice_provider.dart';
import 'package:subs_tracker/widgets/menu_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  @override
  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(settingsSliceProvider).theme;
    return MaterialApp(
      title: 'Subs Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: themeData,
      home: Menubar(),
    );
  }
}
