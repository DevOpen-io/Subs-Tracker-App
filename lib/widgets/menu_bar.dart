import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:subs_tracker/models/sub_slice.dart';
import 'package:subs_tracker/providers/sub_slices_provider.dart';
import 'package:subs_tracker/widgets/add_subs_dialog.dart';
import 'package:subs_tracker/widgets/pie_chart.dart';

class Menubar extends ConsumerStatefulWidget {
  const Menubar({
    super.key,
    required this.isDark,
    required this.onDarkModeChange,
  });

  final bool isDark;
  final ValueChanged<bool> onDarkModeChange;

  @override
  ConsumerState<Menubar> createState() => _MenubarState();
}

class _MenubarState extends ConsumerState<Menubar> {
  late Future<PackageInfo> _pkg;

  @override
  void initState() {
    super.initState();
    _pkg = PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Subs Tracker")),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundImage: AssetImage('assets/pp.gif'),
                    ),
                    SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mustangtr",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "mustangtr@proton.me",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Menu Section
              const _SectionTitle("Main Menu"),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text("Home"),
                onTap: () {
                  // Navigator.pop(context)
                  // Navigator.pushNamed(context , '/home')
                },
              ),
              ListTile(
                leading: const Icon(Icons.star_outline),
                title: const Text("Favorites"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.add_outlined),
                title: const Text('Add Subscription'),
                onTap: () async {
                  Navigator.pop(context);

                  final notifier = ref.read(subSlicesProvider.notifier);
                  final messenger = ScaffoldMessenger.of(context);

                  final SubSlice? result = await showDialog<SubSlice>(
                    context: context,
                    builder: (_) => const AddSubsDialog(),
                  );

                  if (!mounted) return;

                  if (result != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      notifier.addSlice(result);
                    });
                    messenger.showSnackBar(
                      SnackBar(content: Text('Added : ${result.name}')),
                    );
                  }
                },
              ),
              const _SectionTitle('Settings'),
              SwitchListTile(
                secondary: const Icon(Icons.dark_mode_outlined),
                title: const Text("Dark Mode"),
                value: widget.isDark,
                onChanged: (value) => widget.onDarkModeChange(value),
              ),
              ListTile(
                leading: const Icon(Icons.language_outlined),
                title: const Text("Language"),
                onTap: () {},
              ),

              const _SectionTitle("About"),
              FutureBuilder<PackageInfo>(
                future: _pkg,
                builder: (context, snap) {
                  final version = snap.hasData
                      ? "${snap.data!.version} (${snap.data!.buildNumber})"
                      : "—";
                  return AboutListTile(
                    icon: const Icon(Icons.info_outline),
                    applicationName: "SubsTracker",
                    applicationVersion: version,
                    applicationIcon: Image.asset(
                      "assets/App_Logo.png",
                      width: 48,
                      height: 48,
                    ),
                    aboutBoxChildren: [
                      SizedBox(height: 8),
                      Text(
                        "An open source application that allows you to easily track your subscriptions.",
                      ),
                    ],
                    child: const Text("About"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final slices = ref.watch(subSlicesProvider);

          if (slices.isEmpty) {
            return const Center(
              child: Text(
                "Subscription Data Not Added Yet.",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
          return Column(
            children: [
              SubsPie(),
              const SizedBox(height: 12),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: slices.length,
                  itemBuilder: (context, index) {
                    final s = slices[index];
                    final percent =
                        slices.fold<double>(0, (a, b) => a + b.amount) == 0
                        ? 0
                        : (s.amount /
                                  slices.fold<double>(
                                    0,
                                    (a, b) => a + b.amount,
                                  )) *
                              100;

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: s.color,
                          child: Text(
                            s.name[0].toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(s.name),
                        subtitle: Text(
                          "${s.amount.toStringAsFixed(2)} ₺ · ${percent.toStringAsFixed(1)}%",
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            ref
                                .read(subSlicesProvider.notifier)
                                .removeAt(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelSmall?.copyWith(
      letterSpacing: 0.8,
      color: Colors.grey.shade600, // .shade600, [] yerine
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
      child: Text(text.toUpperCase(), style: style),
    );
  }
}
