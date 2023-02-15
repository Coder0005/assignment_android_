import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:freelancer_app/main.dart' as app;

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Register Page', (WidgetTester tester) async {
    // Setup
    app.main();
    await tester.pumpAndSettle();
    final Finder button = find.byIcon(Icons.send);
    // do
    await tester.tap(button);
    await Future.delayed(const Duration(seconds: 4));
    await tester.pumpAndSettle();
    // test
    expect(find.byIcon(Icons.send), findsOneWidget);
    await Future.delayed(const Duration(seconds: 4));
  });
}
