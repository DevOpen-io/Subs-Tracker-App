import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_gravatar_fetch/simple_gravatar_fetch.dart';
import 'package:subs_tracker/providers/settings_controller.dart';
import 'package:subs_tracker/widgets/action_text_form_field.dart';

class EditUserProfileDialog extends ConsumerStatefulWidget {
  const EditUserProfileDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChooseOrEditPPState();
}

class _ChooseOrEditPPState extends ConsumerState<EditUserProfileDialog> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);

      if (image != null) {
        final Uint8List imageBytes = await image.readAsBytes();

        ref
            .read(settingsControllerProvider.notifier)
            .updateProfilePicture(imageBytes);
      }
    } catch (e) {
      debugPrint("Error While Select Image : $e");
    }
  }

  /// Shows a modal bottom sheet with options to choose an image source.
  ///
  /// Displays two options:
  /// 1. Choose from gallery - Opens device's photo gallery
  /// 2. Take a picture - Opens device's camera
  ///
  /// When an option is selected, the modal is dismissed and [_pickImage] is called
  /// with the corresponding [ImageSource].
  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text("intro.choose_gallery".tr()),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text("intro.take_camera".tr()),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsController = ref.watch(settingsControllerProvider);

    return AlertDialog.adaptive(
      title: Text("intro.edit_picture".tr()),
      content: settingsController.when(
        error: (e, st) => Center(child: Text('Error: $e')),
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        data: (slice) => Material(
          type: MaterialType.transparency,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 128,
                backgroundImage: slice.profilePicture != null
                    ? MemoryImage(slice.profilePicture!) as ImageProvider
                    : const AssetImage('assets/pp.gif'),
                backgroundColor: Colors.grey.shade200,
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.center, // Butonları ortalar
                spacing: 8.0, // Butonlar arasındaki yatay boşluk
                runSpacing:
                    8.0, // Alta geçen buton ile üstteki arasındaki dikey boşluk
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.upload_file_outlined),
                    onPressed: _showImageSourceOptions,
                    label: Text("intro.upload_photo".tr()),
                  ),
                  // Aradaki SizedBox'a gerek kalmadı
                  ElevatedButton.icon(
                    icon: const Icon(Icons.link_outlined),
                    onPressed: () async {
                      try {
                        final Uint8List? imageBytes = await getGravatar(
                          slice.email ?? "",
                          size: 500,
                        );

                        if (imageBytes != null) {
                          ref
                              .read(settingsControllerProvider.notifier)
                              .updateProfilePicture(
                                imageBytes,
                              );
                        } else {
                          debugPrint("Cant Get Profile Picture From Gravatar.");
                        }
                      } catch (e) {
                        debugPrint("Error While Select Image : $e");
                      }
                    },
                    label: Text("intro.connect_gravatar".tr()),
                  ),
                ],
              ),
              const Divider(height: 32),
              ActionTextFormField(
                labelText: "intro.username_label".tr(),
                initialValue: slice.userName ?? "",
                onSave: (newUserName) {
                  // Provider'ı güncelle
                  ref
                      .read(settingsControllerProvider.notifier)
                      .updateUserName(newUserName);

                  // (Opsiyonel) Kullanıcıya geri bildirim ver
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("intro.username_saved".tr())),
                  );
                },
              ),
              const SizedBox(height: 8),
              ActionTextFormField(
                labelText: "intro.email_label".tr(),
                initialValue: slice.email ?? "",
                onSave: (newEmail) {
                  // Provider'ı güncelle
                  ref
                      .read(settingsControllerProvider.notifier)
                      .updateUserEmail(newEmail);

                  // (Opsiyonel) Kullanıcıya geri bildirim ver
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("intro.email_saved".tr())));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
