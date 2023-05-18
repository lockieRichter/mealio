import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealio/main.dart';

void main() {
  testWidgets('Add button opens dialog smoke test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that the add ingredients dialog is shown.
    expect(find.byKey(const ValueKey('add_ingredient_dialog_title')),
        findsOneWidget);
  });

  testWidgets('Added ingredient displays in list smoke test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the '+' icon and trigger a frame to open the add ingredient dialog.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Enter an ingredient in the text field.
    await tester.enterText(
        find.byKey(const ValueKey('add_ingredient_text_field')), 'Skittles');

    // Tap the 'Add' button and trigger a frame to close the dialog.
    await tester.tap(find.byKey(const ValueKey('add_ingredient_button')));
    await tester.pump();

    // Verify that the ingredient is displayed in the list.
    expect(find.byKey(const ValueKey('Skittles')), findsOneWidget);
  });
}
