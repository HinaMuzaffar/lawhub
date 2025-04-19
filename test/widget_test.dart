// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lawhub/main.dart';

void main() {
   testWidgets('AuthScreen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Check "Sign Up" button is visible
    expect(find.text('Sign Up'), findsOneWidget);

    // Switch to login
    await tester.tap(find.text('Already have an account? Login'));
    await tester.pump();

    // Now it should show "Login" button
    expect(find.text('Login'), findsOneWidget);
  });
}