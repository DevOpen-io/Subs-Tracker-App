import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:subs_tracker/models/sub_slice.dart';
import 'package:subs_tracker/providers/settings_slice_provider.dart';
import 'package:subs_tracker/utils/notification_service.dart';
import 'package:subs_tracker/widgets/add_subs_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class SidebarMenu extends ConsumerStatefulWidget {
  const SidebarMenu({super.key});

  @override
  ConsumerState<SidebarMenu> createState() => _MenubarState();
}

class _MenubarState extends ConsumerState<SidebarMenu> {
  late Future<PackageInfo> _pkg;

  @override
  void initState() {
    super.initState();
    _pkg = PackageInfo.fromPlatform();
  }

  final Uri _url = Uri.parse('https://github.com/kullaniciAdin/subs_tracker');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsSliceProvider).theme;
    return Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "mustangtr@proton.me",
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 14),
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

                  await showAdaptiveDialog<SubSlice>(
                    context: context,
                    builder: (_) => const AddSubsDialog(),
                  );
                },
              ),
              const _SectionTitle('Settings'),
              SwitchListTile(
                secondary: const Icon(Icons.dark_mode_outlined),
                title: const Text("Dark Mode"),
                value: theme == ThemeMode.dark || theme == ThemeMode.system,
                onChanged: (value) {
                  ref.read(settingsSliceProvider.notifier).updateTheme(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
                },
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
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: _launchUrl,
                        child: Text(
                          "View on GitHub",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                    child: const Text("About"),
                  );
                },
              ),
            ],
          ),
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
      color: Theme.of(context).colorScheme.onSurface,
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
      child: Text(text.toUpperCase(), style: style),
    );
  }
}
