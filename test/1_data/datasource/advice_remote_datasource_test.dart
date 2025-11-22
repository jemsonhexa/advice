import 'package:advisor/1_data/datasource/advice_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('AdviceRemoteDatasource', () {
    group("should return adviceModel", () {
      test("while response is 200 & has a valid data", () {
        final mockClient = MockClient();
        final adviceRemoteDatasource = AdviceRemoteDatasourceImpl(
          client: mockClient,
        );
        const responseBody = {"advice": "test-advice", "id": 1};
      });
    });
  });
}
