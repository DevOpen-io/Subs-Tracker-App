import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subs_tracker/providers/settings_controller.dart';
import 'package:subs_tracker/widgets/bottom_controls.dart';
import 'package:subs_tracker/widgets/intro_page.dart';
import 'package:subs_tracker/widgets/profile_page.dart';
import 'package:subs_tracker/widgets/user_name_page.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController pageController = usePageController();
    final currentPage = useState<int>(0);

    void finishOnboarding() {
      ref.read(settingsControllerProvider.notifier).updateIsFirstTime(false);
      // Navigate to home or root
      context.go('/home');
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (int page) {
                  currentPage.value = page;
                },
                children: const [
                  IntroPage(),
                  UserNamePage(),
                  ProfilePage(),
                ],
              ),
            ),
            BottomControls(
              currentPage: currentPage,
              pageController: pageController,
              finishOnboarding: finishOnboarding,
            ),
          ],
        ),
      ),
    );
  }
}
