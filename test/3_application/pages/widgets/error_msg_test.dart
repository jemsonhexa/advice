import 'package:advisor/3_application/pages/advisor/widgets/error_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  widgetUnderTest({required String errMsg}) {
    return MaterialApp(home: ErrorMsg(errMsg: errMsg));
  }

  group("Error Field", () {
    group("Should show correctly", () {
      testWidgets("A short text is given", (widgetTester) async {
        const text = 'a';

        await widgetTester.pumpWidget(widgetUnderTest(errMsg: text));

        await widgetTester.pumpAndSettle();

        final errorFieldFinder = find.textContaining('a');

        expect(errorFieldFinder, findsOneWidget);
      });

      //when a long text comes
      testWidgets("A long text is given", (widgetTester) async {
        const text = 'This is a very looooong eroor msg';

        await widgetTester.pumpWidget(widgetUnderTest(errMsg: text));

        await widgetTester.pumpAndSettle();

        final errorFieldFinder = find.byType(ErrorMsg);

        expect(errorFieldFinder, findsOneWidget);
      });
    });
  });
}
