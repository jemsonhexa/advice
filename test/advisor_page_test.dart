import 'package:advisor/3_application/core/services/theme_services.dart';
import 'package:advisor/3_application/pages/advisor/advisor_page.dart';
import 'package:advisor/3_application/pages/advisor/cubit/advisor_cubit.dart';
import 'package:advisor/3_application/pages/advisor/widgets/advice_field.dart';
import 'package:advisor/3_application/pages/advisor/widgets/error_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:provider/provider.dart';

class MockAdvicerCubit extends MockCubit<AdvisorCubitState>
    implements AdvisorCubit {}

void main() {
  Widget widgetUnderTest({required AdvisorCubit cubit}) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => ThemeService(),
        child: BlocProvider<AdvisorCubit>(
          create: (context) => cubit,
          child: const AdvisorPage(),
        ),
      ),
    );
  }

  group('AdvicerPage', () {
    late AdvisorCubit mockAdvicerCubit;

    setUp(() {
      mockAdvicerCubit = MockAdvicerCubit();
    });
    group('should be displayed in ViewState', () {
      testWidgets('Initial when cubits emits AdvicerInitial()', (
        widgetTester,
      ) async {
        whenListen(
          mockAdvicerCubit,
          Stream.fromIterable([AdvisorInitial()]),
          initialState: AdvisorInitial(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));

        final advicerInitalTextFinder = find.text(
          'Your Advice is waiting for you!',
        );

        expect(advicerInitalTextFinder, findsOneWidget);
      });

      testWidgets('Loading when cubits emits AdvicerStateLoading()', (
        widgetTester,
      ) async {
        whenListen(
          mockAdvicerCubit,
          Stream.fromIterable([AdvisorLoadingState()]),
          initialState: AdvisorInitial(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
        await widgetTester.pump();

        final advicerLoadingFinder = find.byType(CircularProgressIndicator);

        expect(advicerLoadingFinder, findsOneWidget);
      });

      testWidgets('advice text when cubits emits AdvicerStateLoaded()', (
        widgetTester,
      ) async {
        whenListen(
          mockAdvicerCubit,
          Stream.fromIterable(const [AdvisorLoadedState(advice: '42')]),
          initialState: AdvisorInitial(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
        await widgetTester.pump();

        final advicerLoadedStateFinder = find.byType(AdviceField);
        final adviceText = widgetTester
            .widget<AdviceField>(advicerLoadedStateFinder)
            .advice;

        expect(advicerLoadedStateFinder, findsOneWidget);
        expect(adviceText, '42');
      });

      testWidgets('Error when cubits emits AdvicerStateError()', (
        widgetTester,
      ) async {
        whenListen(
          mockAdvicerCubit,
          Stream.fromIterable(const [AdvisorErrorState(errorMsg: 'error')]),
          initialState: AdvisorInitial(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
        await widgetTester.pump();

        final advicerErrorFinder = find.byType(ErrorMsg);

        expect(advicerErrorFinder, findsOneWidget);
      });
    });
  });
}
