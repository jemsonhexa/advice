import 'package:advisor/1_data/datasource/advice_remote_datasource.dart';
import 'package:advisor/1_data/exceptions/exceptions.dart';
import 'package:advisor/2_domain/entities/advice_entity.dart';
import 'package:advisor/2_domain/failures/failures.dart';
import 'package:advisor/2_domain/repository/advice_repo.dart';
import 'package:dartz/dartz.dart';

class AdviceRepoImpli implements AdviceRepo {
  final AdviceRemoteDatasource adviceRemoteDatasource =
      AdviceRemoteDatasourceImpl();

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    try {
      final result = await adviceRemoteDatasource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
