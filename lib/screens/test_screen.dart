import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Removed the Scaffold from here.
    return const Scaffold(
      body: Column(
        children: [
          Center(child: Text("Test Page"))
        ],
      ),
    );
  }
}
