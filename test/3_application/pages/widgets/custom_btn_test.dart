import 'package:advisor/3_application/pages/advisor/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class OnCustomButtonTap {
  void call();
}

class MockOnCustomButtonTap extends Mock
    implements OnCustomButtonTap {} //created mock class

void main() {
  Widget widgetUnderTestMethod(Function()? callback) {
    return MaterialApp(
      home: Scaffold(body: CustomBtn(onTap: callback)),
    );
  }

  group("CustomButton", () {
    group("is Button rendered correctly", () {
      testWidgets("and has all parts that it needed", (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTestMethod(() {}));

        final buttonLabelFinder = find.text('Get Advice');

        expect(buttonLabelFinder, findsOneWidget);
      });

      //test onTap
      group("Should handle onTap", () {
        testWidgets("When user pressed button", (widgetTester) async {
          final mockCustomBtnOnTap = MockOnCustomButtonTap();

          await widgetTester.pumpWidget(
            widgetUnderTestMethod(mockCustomBtnOnTap.call),
          );

          final customButtonFinder = find.byType(CustomBtn);

          await widgetTester.tap(customButtonFinder);

          verify(mockCustomBtnOnTap()).called(1);
        });
      });
    });
  });
}
