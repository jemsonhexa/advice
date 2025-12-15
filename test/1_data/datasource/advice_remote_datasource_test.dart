import 'package:advisor/1_data/datasource/advice_remote_datasource.dart';
import 'package:advisor/1_data/exceptions/exceptions.dart';
import 'package:advisor/1_data/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'advice_remote_datasource_test.mocks.dart';

final mockClient = MockClient();
final adviceRemoteDatasourceUnderTest = AdviceRemoteDatasourceImpl(
  client: mockClient,
);

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('AdviceRemoteDatasource', () {
    group('Should return Advice Model', () {
      test(
        "should return AdviceModel while response is 200 & has a valid data",
        () async {
          // Arrange

          const responseBody = '''
      {
        "slip": {
          "advice": "test-advice",
          "id": 1
        }
      }
      ''';

          when(
            mockClient.get(
              Uri.parse('https://api.adviceslip.com/advice'),
              headers: {'accept': 'application/json '},
              // headers: {'content-type': 'application/json '},
            ),
          ).thenAnswer(
            (realInvocation) => Future.value(Response(responseBody, 200)),
          );

          // Act
          final result = await adviceRemoteDatasourceUnderTest
              .getRandomAdviceFromApi();

          // Assert
          expect(result, AdviceModel(advice: "test-advice", id: 1));
        },
      );
    });

    //error test
    group("Should throw", () {
      test("Server Exception at status 400", () {
        when(
          mockClient.get(
            Uri.parse('https://api.adviceslip.com/advice'),
            headers: {'accept': 'application/json '},
            // headers: {'content-type': 'application/json '},
          ),
        ).thenAnswer((realInvocation) => Future.value(Response("", 201)));

        expect(
          () => adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi(),
          throwsA(isA<ServerException>()),
        );
      });

      //test
      test("TypeError while status code is 200 but no valid data ", () {
        //should give a unexcepted result not the correct one
        const responseBody = '''
            {
              "slip": {
                "advice": 123,
                "id": "abc"
              }
            }
            ''';

        when(
          mockClient.get(
            Uri.parse('https://api.adviceslip.com/advice'),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => Response(responseBody, 200));

        expect(
          () async =>
              await adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi(),
          throwsA(isA<TypeError>()),
        );
      });
    });
  });
}
