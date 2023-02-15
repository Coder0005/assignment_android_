import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:freelancer_app/main.dart' as app;

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login to dashboard', (WidgetTester tester) async {
    // Setup
    app.main();
    await tester.pumpAndSettle();
    final Finder button = find.byIcon(Icons.login);
    // do

    await tester.tap(button);
    await Future.delayed(const Duration(seconds: 1));

    await tester.pumpAndSettle();
    // test

    expect(find.byIcon(Icons.login), findsOneWidget);
    await Future.delayed(const Duration(seconds: 1));
  });
  testWidgets('Clear Entries', (WidgetTester tester) async {
    // Setup
    app.main();
    await tester.pumpAndSettle();
    final Finder button = find.byIcon(Icons.delete);
    // do

    await tester.tap(button);
    await Future.delayed(const Duration(seconds: 1));

    await tester.pumpAndSettle();
    // test

    expect(find.byIcon(Icons.delete), findsOneWidget);
    await Future.delayed(const Duration(seconds: 1));
  });
  testWidgets('Move To Register', (WidgetTester tester) async {
    // Setup
    app.main();
    await tester.pumpAndSettle();
    final Finder button = find.byIcon(Icons.fork_right);
    // do

    await tester.tap(button);
    await Future.delayed(const Duration(seconds: 1));

    await tester.pumpAndSettle();
    // test

    expect(find.byIcon(Icons.send), findsNothing);
    await Future.delayed(const Duration(seconds: 1));
  });
  // testWidgets('Jump to dashboard', (WidgetTester tester) async {
  //   // Setup
  //   app.main();
  //   await tester.pumpAndSettle();
  //   final Finder button = find.byIcon(Icons.login);
  //   // do

  //   await tester.tap(button);
  //   await Future.delayed(const Duration(seconds: 1));

  //   await tester.pumpAndSettle();
  //   // test

  //   expect(find.byIcon(Icons.login), findsOneWidget);
  //   await Future.delayed(const Duration(seconds: 1));
  // });
}
