import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:subs_tracker/pie_chart.dart';

class Menubar extends StatefulWidget {
  const Menubar({
    super.key,
    required this.isDark,
    required this.onDarkModeChange,
  });

  final bool isDark;
  final ValueChanged<bool> onDarkModeChange;

  @override
  State<Menubar> createState() => _MenubarState();
}

class _MenubarState extends State<Menubar> {
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
      body: Column(
        children: [
            SubsPie(),
            const SizedBox(height: 12,),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Column(
                children: [
                  
                ],
              ),
            )
          ]
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
