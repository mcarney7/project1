import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:project1/main.dart';

void main() {
  // Group tests to make them organized
  group('Girl Math Finance App Tests', () {
    testWidgets('Login Screen Navigation Test', (WidgetTester tester) async {
      // Build the app and trigger a frame.
      await tester.pumpWidget(MyApp());

      // Verify that the Login Screen is initially displayed.
      expect(find.text('Login'), findsOneWidget);

      // Assuming your Login button has text "Login" or an icon.
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Verify that after login, the app navigates to the Dashboard.
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('Test Navigation to Income Screen', (WidgetTester tester) async {
      // Build the app and trigger a frame.
      await tester.pumpWidget(MyApp());

      // Simulate navigating from Login to Dashboard
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Verify Dashboard is displayed
      expect(find.text('Dashboard'), findsOneWidget);

      // Simulate tapping on the button to navigate to the Income screen
      await tester.tap(find.text('Add Income'));
      await tester.pumpAndSettle();

      // Verify that the Income screen is displayed
      expect(find.text('Add Income'), findsOneWidget);
    });

    testWidgets('Test Income Entry', (WidgetTester tester) async {
      // Build the app and trigger a frame.
      await tester.pumpWidget(MyApp());

      // Simulate navigating to the Income screen
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add Income'));
      await tester.pumpAndSettle();

      // Entering data in Income screen fields
      await tester.enterText(find.byType(TextField).at(0), 'Freelancing');
      await tester.enterText(find.byType(TextField).at(1), '1000');
      await tester.pump();

      // Simulate pressing the Save button
      await tester.tap(find.text('Save Income'));
      await tester.pumpAndSettle();

      // Verify that the Income has been added
      expect(find.text('Freelancing'), findsOneWidget);
      expect(find.text('1000'), findsOneWidget);
    });
  });
}
