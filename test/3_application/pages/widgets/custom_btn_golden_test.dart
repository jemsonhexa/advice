import 'package:advisor/3_application/pages/advisor/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderTest({Function()? onTap}) {
    return MaterialApp(
      home: Scaffold(body: CustomBtn(onTap: onTap)),
    );
  }

  group('Golden Test', () {
    group('Custom Button', () {
      testWidgets('is enabled', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest(onTap: () {}));

        await expectLater(
          find.byType(CustomBtn),
          matchesGoldenFile('goldens/custom_button_enabled.png'),
        );
      });

      testWidgets('is disabled', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest());

        await expectLater(
          find.byType(CustomBtn),
          matchesGoldenFile('goldens/custom_button_disabled.png'),
        );
      });
    });
  });
}
