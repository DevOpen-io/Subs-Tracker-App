import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class SecondScreen extends ConsumerStatefulWidget {
  const SecondScreen({super.key});

  @override
  ConsumerState<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends ConsumerState<SecondScreen> {
  StateController<List<Widget>?>? _appBarActionsNotifier;

  @override
  void initState() {
    super.initState();
    _appBarActionsNotifier?.state = null;
  }

  @override
  Widget build(BuildContext context) {
    return const Column(children: [Center(child: Text("Second Page"))]);
  }
}
