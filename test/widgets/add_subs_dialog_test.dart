import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subs_tracker/models/brand.dart';
import 'package:subs_tracker/models/sub_slice.dart';
import 'package:subs_tracker/providers/brands_provider.dart';
import 'package:subs_tracker/providers/subs_controller.dart';
import 'package:subs_tracker/widgets/add_subs_dialog.dart';

// Mock Brands
class FakeBrands extends Brands {
  @override
  Future<List<Brand>> build() async {
    return [
      const Brand(text: 'Netflix', logo: null),
      const Brand(text: 'Spotify', logo: null),
    ];
  }
}

// Mock SubsController
class MockSubsController extends SubsController {
  List<SubSlice> addedSlices = [];

  @override
  Future<List<SubSlice>> build() async {
    return [];
  }

  @override
  void addSlice(SubSlice slice) {
    addedSlices.add(slice);
  }
}

void main() {
  testWidgets('AddSubsDialog allows adding a subscription', (WidgetTester tester) async {
    final mockSubsController = MockSubsController();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          brandsProvider.overrideWith(() => FakeBrands()),
          subsControllerProvider.overrideWith(() => mockSubsController),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: AddSubsDialog(),
          ),
        ),
      ),
    );

    // Wait for async providers to load
    await tester.pumpAndSettle();

    // Verify initial state
    expect(find.text('Add Subscription'), findsOneWidget);
    expect(find.text('Brand or custom name'), findsOneWidget);

    // Enter Name
    await tester.enterText(find.byType(TextFormField).at(0), 'My Sub');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    // Enter Amount
    await tester.enterText(find.byType(TextFormField).at(1), '10.0');
    await tester.pump();

    // Select Frequency (Dropdown)
    // Note: DropdownButtonFormField might be hard to tap in test if it's not visible or needs scrolling.
    // But let's try to find it.
    expect(find.text('MONTHLY'), findsOneWidget); // Default value
    await tester.tap(find.text('MONTHLY'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('WEEKLY').last);
    await tester.pumpAndSettle();
    expect(find.text('WEEKLY'), findsOneWidget);

    // Tap Add
    await tester.tap(find.text('Add'));
    await tester.pump();

    // Verify slice was added
    expect(mockSubsController.addedSlices, hasLength(1));
    expect(mockSubsController.addedSlices.first.name, 'My Sub');
    expect(mockSubsController.addedSlices.first.amount, 10.0);
    expect(mockSubsController.addedSlices.first.frequency, Frequency.weekly);
  });
}
