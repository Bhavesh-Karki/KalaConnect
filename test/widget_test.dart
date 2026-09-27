import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalaconnect/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('KalaConnect shows the offline catalogue', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final storage =
        LocalStorageService(await SharedPreferences.getInstance());
    final controller = AppController(storage);

    // Pass testEnquiries: [] to skip SQLite entirely in this test.
    // The real SQLite path runs on the actual Android/iOS/Windows device.
    // Widget tests run in a headless Dart VM with no native platform plugin,
    // so we provide an empty list instead of opening the database.
    await controller.load(testEnquiries: []);

    await tester.pumpWidget(KalaConnectApp(controller: controller));

    // Home screen is loaded via Named Route initialRoute '/' (Unit 3.2)
    expect(find.text('KalaConnect'), findsOneWidget);
    expect(
      find.text('Discover artisans. Explore crafts. Preserve stories.'),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(
      find.textContaining('products found'),
      220,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.textContaining('products found'), findsOneWidget);
  });
}
