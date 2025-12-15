import 'package:advisor/2_domain/entities/advice_entity.dart';
import 'package:advisor/2_domain/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:advisor/1_data/repository/advice_repo_impli.dart';
import 'package:advisor/2_domain/usecases/advice_usecase.dart';
import 'package:mockito/mockito.dart';

import 'advice_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepoImpli>()])
void main() {
  group("AdviceUsecases", () {
    group("Should return advice entity", () {
      test("when adviceRepoImpl return a Advice Model", () async {
        final mockAdviceRepoImpl = MockAdviceRepoImpli();

        final adviceUseCasesUnderTest = AdviceUsecase(
          adviceRepo: mockAdviceRepoImpl,
        );

        when(mockAdviceRepoImpl.getAdviceFromDataSource()).thenAnswer(
          (realInvocation) =>
              Future.value(const Right(AdviceEntity(advice: 'test', id: 42))),
        );

        final result = await adviceUseCasesUnderTest.getAdvice();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);

        expect(
          result,
          Right<Failure, AdviceEntity>(AdviceEntity(advice: "test", id: 42)),
        );

        verify(mockAdviceRepoImpl.getAdviceFromDataSource()).called(1);
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });
    });
  });

  //test failures
  group("Should return left with", () {
    test("A Server Failure", () async {
      final mockAdviceRepoImpl = MockAdviceRepoImpli();

      final adviceUseCasesUnderTest = AdviceUsecase(
        adviceRepo: mockAdviceRepoImpl,
      );

      when(
        mockAdviceRepoImpl.getAdviceFromDataSource(),
      ).thenAnswer((realInvocation) => Future.value(Left(ServerFailure())));

      final result = await adviceUseCasesUnderTest.getAdvice();

      expect(result.isLeft(), true);
      expect(result.isRight(), false);

      expect(result, Left<Failure, AdviceEntity>(ServerFailure()));

      verify(mockAdviceRepoImpl.getAdviceFromDataSource()).called(1);
      verifyNoMoreInteractions(mockAdviceRepoImpl);
    });
  });
}
