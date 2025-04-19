import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lawhub/main.dart'; // 👈 Make sure the path matches your actual structure

void main() {
  testWidgets('MyApp renders MaterialApp and home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Check for MaterialApp
    expect(find.byType(MaterialApp), findsOneWidget);

    // Check AuthScreen initially loaded
    expect(find.text('Sign Up'), findsOneWidget); // Button or AppBar Title
  });

  testWidgets('Switch from SignUp to Login', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final toggleBtn = find.text("Already have an account? Login");
    expect(toggleBtn, findsOneWidget);

    await tester.tap(toggleBtn);
    await tester.pump(); // Update UI

    expect(find.text("Create a new account"), findsOneWidget); // Now shows Login screen text
  });
}
