import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealio/main.dart';
import 'package:mealio/models/ingredient.dart';
import 'package:mealio/providers/database.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import 'widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Database>()])
void main() {
  testWidgets('Add button opens dialog smoke test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that the add ingredients dialog is shown.
    expect(find.byKey(const ValueKey('add_ingredient_dialog_title')),
        findsOneWidget);
  });

  testWidgets('Added ingredient displays in list smoke test',
      (WidgetTester tester) async {
    final mockDb = MockDatabase();
    when(mockDb.query(any)).thenAnswer((_) async => []);

    // Build our app and trigger a frame.
    await tester.pumpWidget(ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(mockDb),
      ],
      child: const MyApp(),
    ));

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
    expect(find.byKey(const ValueKey('1-Skittles')), findsOneWidget);
  });

  testWidgets('Existing ingredients show at startup smoke test',
      (WidgetTester tester) async {
    final mockDb = MockDatabase();
    when(mockDb.query(any)).thenAnswer(
      (_) async => [
        const Ingredient(id: 1, name: "Bread").toJson(),
      ],
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(mockDb),
        ],
        child: const MyApp(),
      ),
      const Duration(milliseconds: 500),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump();

    // Verify that the ingredient is displayed in the list.
    expect(find.byKey(const ValueKey('1-Bread')), findsOneWidget);
  });
}
