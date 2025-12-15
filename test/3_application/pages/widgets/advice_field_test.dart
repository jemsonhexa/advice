import 'package:advisor/3_application/pages/advisor/widgets/advice_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  widgetUnderTest({required String adviceText}) {
    return MaterialApp(home: AdviceField(advice: adviceText));
  }

  group("Advice Field", () {
    group("Should show correctly", () {
      testWidgets("A short text is given", (widgetTester) async {
        const text = 'a';

        await widgetTester.pumpWidget(widgetUnderTest(adviceText: text));

        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.textContaining('a');

        expect(adviceFieldFinder, findsOneWidget);
      });

      //when a long text comes
      testWidgets("A long text is given", (widgetTester) async {
        const text = 'hello flutter iam here looking';

        await widgetTester.pumpWidget(widgetUnderTest(adviceText: text));

        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.byType(AdviceField);

        expect(adviceFieldFinder, findsOneWidget);
      });

      //no text
      testWidgets("No text is given", (widgetTester) async {
        const text = '';

        await widgetTester.pumpWidget(widgetUnderTest(adviceText: text));

        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.text(AdviceField.emptyAdvice);

        final adviceText = widgetTester
            .widget<AdviceField>(find.byType(AdviceField))
            .advice;

        expect(adviceFieldFinder, findsOneWidget);
        expect(adviceText, '');
      });
    });
  });
}
