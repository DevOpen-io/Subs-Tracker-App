import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold'u buradan kaldırıyoruz.
    return const Column(children: [Center(child: Text("Test Page"))]);
  }
}
