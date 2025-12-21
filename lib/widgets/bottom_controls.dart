import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BottomControls extends StatelessWidget {
  const BottomControls({
    super.key,
    required this.currentPage,
    required this.pageController,
    required this.finishOnboarding,
  });

  final ValueNotifier<int> currentPage;
  final PageController pageController;
  final VoidCallback finishOnboarding;




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentPage.value > 0)
            TextButton(
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Text('common.back'.tr()),
            )
          else
            const SizedBox(width: 64), // Placeholder for alignment
          Row(
            children: List.generate(
              3,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentPage.value == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade300,
                ),
              ),
            ),
          ),
          if (currentPage.value < 2)
            TextButton(
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Text('common.next'.tr()),
            )
          else
            ElevatedButton(
              onPressed: finishOnboarding,
              child: Text('common.finish'.tr()),
            ),
        ],
      ),
    );
  }
}