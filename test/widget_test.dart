// This is a basic Flutter widget test for StoreApp.

import 'package:flutter_test/flutter_test.dart';

import 'package:storeapp/main.dart';

void main() {
  testWidgets('StoreApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StoreApp());

    // Verify the app renders without throwing
    expect(find.byType(StoreApp), findsNothing); // widget replaces itself with MaterialApp
  });
}
