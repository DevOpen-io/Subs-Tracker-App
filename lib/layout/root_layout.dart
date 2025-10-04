import 'package:flutter/material.dart';
import 'package:subs_tracker/models/sub_slice.dart';
import 'package:subs_tracker/widgets/add_subs_dialog.dart';
import 'package:subs_tracker/widgets/menu_bar.dart';

class RootLayout extends StatelessWidget {
  const RootLayout({super.key, required this.child});
  
  final Widget child; // GoRouter'ın buraya HomeScreen veya TestScreen'i yerleştireceği değişken

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subs Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              await showAdaptiveDialog<SubSlice>(
                context: context,
                builder: (_) => const AddSubsDialog(),
              );
            },
          ),
        ],
      ),
      drawer: const SidebarMenu(),
      body: child, // İçerik olarak gelen sayfayı burada gösteriyoruz.
    );
  }
}
