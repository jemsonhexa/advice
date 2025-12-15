import 'package:advisor/2_domain/entities/advice_entity.dart';
import 'package:advisor/2_domain/failures/failures.dart';
import 'package:advisor/2_domain/usecases/advice_usecase.dart';
import 'package:advisor/3_application/pages/advisor/cubit/advisor_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAdviceUseCases extends Mock implements AdviceUsecase {}

void main() {
  group("AdviceCubit", () {
    group("should emit", () {
      MockAdviceUseCases mockAdviceUseCases = MockAdviceUseCases();

      blocTest(
        "Nothing when no method called",
        build: () => AdvisorCubit(advisorUsecase: mockAdviceUseCases),
        expect: () => const <AdvisorCubitState>[],
      );

      blocTest(
        "[AdviserLoading,AdviserStateLoaded] when adviceRequested() is called",
        setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
          (invocation) => Future.value(
            Right<Failure, AdviceEntity>(AdviceEntity(advice: "advice", id: 1)),
          ),
        ),

        build: () => AdvisorCubit(advisorUsecase: mockAdviceUseCases),
        act: (cubit) => cubit.adviceRequested(),
        expect: () => <AdvisorCubitState>[
          AdvisorLoadingState(),
          AdvisorLoadedState(advice: 'advice'),
        ],
      );

      group(
        "[AdviceStateLoading,AdviceStateError] when adviceRequest is called",
        () {
          blocTest<AdvisorCubit, AdvisorCubitState>(
            "and a serverFailure occurs",
            setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
              (invocation) =>
                  Future.value(Left<Failure, AdviceEntity>(ServerFailure())),
            ),
            build: () => AdvisorCubit(advisorUsecase: mockAdviceUseCases),
            act: (cubit) => cubit.adviceRequested(),
            expect: () => <AdvisorCubitState>[
              AdvisorLoadingState(),
              AdvisorErrorState(errorMsg: serverErrorMsg),
            ],
          );
        },
      );
    });
  });
}
