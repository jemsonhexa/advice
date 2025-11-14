import 'package:advisor/1_data/repository/advice_repo_impli.dart';
import 'package:advisor/2_domain/entities/advice_entity.dart';
import 'package:advisor/2_domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

class AdviceUsecase {
  final adviceRepo = AdviceRepoImpli();

  //the helper functions which gets called in bloc/cubit
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDataSource();
    //business loagic comes here

    //removed below codes because we directly calls advice repo
    // await Future.delayed(Duration(seconds: 2), () {});
    // //if call to repo is sucess then return right- advice entity
    // return right(AdviceEntity(advice: "A fake advice", id: 1));

    //else if a failure then left- error
    // return left(CacheFailure());
  }
}
