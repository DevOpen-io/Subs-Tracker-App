import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:subs_tracker/config/router_config.dart';
import 'package:subs_tracker/models/sub_slice.dart';
import 'package:subs_tracker/providers/settings_controller.dart';
import 'package:subs_tracker/providers/subs_controller.dart';
import 'package:subs_tracker/widgets/add_subs_dialog.dart';
import 'package:subs_tracker/widgets/edit_user_profile.dart';
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

  final Uri _url = Uri.parse('https://github.com/DevOpen-io/Subs-Tracker-App');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> _exportSubscriptions() async {
    try {
      final controller = ref.read(subsControllerProvider.notifier);
      final jsonString = await controller.exportToJson();

      // Get a directory to save the file
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'subscriptions_backup_$timestamp.json';

      // On mobile, use share
      if (Platform.isAndroid || Platform.isIOS) {
        final tempDir = Directory.systemTemp;
        final tempFile = File('${tempDir.path}/$fileName');
        await tempFile.writeAsString(jsonString);

        await Share.shareXFiles([
          XFile(tempFile.path),
        ], subject: 'Subscriptions Backup');
      } else {
        // On desktop, use file picker to select save location
        final result = await FilePicker.platform.saveFile(
          dialogTitle: 'Save Subscriptions Backup',
          fileName: fileName,
          type: FileType.custom,
          allowedExtensions: ['json'],
        );

        if (result != null) {
          final file = File(result);
          await file.writeAsString(jsonString);

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Subscriptions exported successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error exporting subscriptions: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _importSubscriptions() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final jsonString = await file.readAsString();

        final controller = ref.read(subsControllerProvider.notifier);
        final success = await controller.importFromJson(jsonString);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                success
                    ? 'Subscriptions imported successfully!'
                    : 'Error importing subscriptions. Invalid file format.',
              ),
              backgroundColor: success ? Colors.green : Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error importing subscriptions: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsController = ref.watch(settingsControllerProvider);

    return Drawer(
      child: settingsController.when(
        error: (e, st) => Center(child: Text('Error: $e')),
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        data: (slice) => SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundImage: slice.profilePicture != null
                              ? MemoryImage(slice.profilePicture!)
                                    as ImageProvider // Seçilen resim
                              : const AssetImage('assets/pp.gif'),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                slice.userName ?? "",
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                slice.email ?? "",
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: -8,
                      right: -8,
                      child: IconButton(
                        onPressed: () async {
                          await showAdaptiveDialog(
                            context: context,
                            builder: (_) => const EditUserProfileDialog(),
                          );
                        },
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                        ),
                      ),
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
                  Navigator.of(context).pop();
                  context.go(Routes.home.route);
                  // Navigator.pop(context)
                  // Navigator.pushNamed(context , '/home')
                },
              ),
              ListTile(
                leading: const Icon(Icons.texture_sharp),
                title: const Text("Second Page"),
                onTap: () {
                  Navigator.of(context).pop();
                  context.go(Routes.second.route);
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
                value:
                    settingsController.value?.theme == ThemeMode.dark ||
                    settingsController.value?.theme == ThemeMode.system,
                onChanged: (value) {
                  ref
                      .read(settingsControllerProvider.notifier)
                      .updateSettingsSliceData(
                        theme: value ? ThemeMode.dark : ThemeMode.light,
                      );
                },
              ),
              ListTile(
                leading: const Icon(Icons.language_outlined),
                title: const Text("Language"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.upload_file_outlined),
                title: const Text("Export Subscriptions"),
                onTap: () {
                  _exportSubscriptions();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.download_outlined),
                title: const Text("Import Subscriptions"),
                onTap: () {
                  _importSubscriptions().then((_) {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  });
                },
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
