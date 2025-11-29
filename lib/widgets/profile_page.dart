import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_gravatar_fetch/simple_gravatar_fetch.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({
    super.key,
    required this.profilePicture,
    required this.isGravatarLoading,
    required this.emailController,
  });

  final TextEditingController emailController;
  final ValueNotifier<bool> isGravatarLoading;
  final ValueNotifier<Uint8List?> profilePicture;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();
      profilePicture.value = bytes;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32.0, 60.0, 32.0, 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Profile Image Preview
            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Theme.of(context).cardColor,
                backgroundImage: profilePicture.value != null
                    ? MemoryImage(profilePicture.value!)
                    : null,
                child: profilePicture.value == null
                    ? Icon(
                        Icons.person_outline_rounded,
                        size: 80,
                        color: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.5),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 40),

            // Added Title for consistency
            Text(
              'Complete your\nprofile',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Email Input
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'example@email.com',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: pickImage,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    icon: const Icon(Icons.photo_library_rounded),
                    label: const Text('Gallery'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isGravatarLoading.value
                        ? null
                        : () async {
                            if (emailController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please Enter Your Email Address.",
                                  ),
                                ),
                              );
                              return;
                            }

                            isGravatarLoading.value = true;

                            try {
                              final Uint8List? imageBytes = await getGravatar(
                                emailController.text,
                                size: 500,
                              );

                              if (imageBytes != null) {
                                profilePicture.value = imageBytes;
                              } else {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Cant Get Profile Picture From Gravatar.",
                                      ),
                                    ),
                                  );
                                }
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Error While Select Image : $e",
                                    ),
                                  ),
                                );
                              }
                            } finally {
                              if (context.mounted) {
                                isGravatarLoading.value = false;
                              }
                            }
                          },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    icon: isGravatarLoading.value
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : const Icon(Icons.download_rounded),
                    label: Text(isGravatarLoading.value ? 'Loading...' : 'Gravatar'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Choose a photo from your gallery or fetch it from Gravatar using your email.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
