import 'package:advisor/2_domain/entities/advice_entity.dart';
import 'package:advisor/2_domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

//its just plan for structuring the real advice repo implementation
//here we defines what functions we will need in real advice repo which will be in
//data layer
abstract class AdviceRepo {
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource();
}
