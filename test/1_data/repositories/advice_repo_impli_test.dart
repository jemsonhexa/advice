import 'package:advisor/1_data/datasource/advice_remote_datasource.dart';
import 'package:advisor/1_data/exceptions/exceptions.dart';
import 'package:advisor/1_data/models/advice_model.dart';
import 'package:advisor/1_data/repository/advice_repo_impli.dart';
import 'package:advisor/2_domain/entities/advice_entity.dart';
import 'package:advisor/2_domain/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_repo_impli_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AdviceRemoteDatasourceImpl>(),
]) //class name in advice datasource repo
void main() {
  group("AdviceRepoImpl", () {
    group("Should return AdviceEntity", () {
      test("When adviceRemoteDataSource return", () async {
        final mockAdviceRemoteDatasource =
            MockAdviceRemoteDatasourceImpl(); //run build runner to get file

        final adviceRepoImplUnderTest = AdviceRepoImpli(
          adviceRemoteDatasource: mockAdviceRemoteDatasource,
        );

        when(mockAdviceRemoteDatasource.getRandomAdviceFromApi()).thenAnswer(
          (realInvocation) =>
              Future.value(AdviceModel(advice: "Testt", id: 41)),
        );

        final result = await adviceRepoImplUnderTest.getAdviceFromDataSource();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);

        expect(
          result,
          Right<Failure, AdviceModel>(AdviceModel(advice: "Testt", id: 41)),
        );

        verify(
          mockAdviceRemoteDatasource.getRandomAdviceFromApi(),
        ).called(1); //getrandomAdvicefromApi is called 1 time

        verifyNoMoreInteractions(mockAdviceRemoteDatasource);
      });

      //next left error test
      group("should return left with", () {
        test("A server failure when server failure occures", () async {
          final mockAdviceRemoteDatasource = MockAdviceRemoteDatasourceImpl();

          final adviceRepoImplUnderTest = AdviceRepoImpli(
            adviceRemoteDatasource: mockAdviceRemoteDatasource,
          );

          when(
            mockAdviceRemoteDatasource.getRandomAdviceFromApi(),
          ).thenThrow(ServerException());

          final result = await adviceRepoImplUnderTest
              .getAdviceFromDataSource();

          expect(result.isLeft(), true);
          expect(result.isRight(), false);

          expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
        });
      });
    });
  });
}
