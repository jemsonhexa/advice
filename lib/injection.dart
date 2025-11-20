import 'package:advisor/1_data/datasource/advice_remote_datasource.dart';
import 'package:advisor/1_data/repository/advice_repo_impli.dart';
import 'package:advisor/2_domain/repository/advice_repo.dart';
import 'package:advisor/2_domain/usecases/advice_usecase.dart';
import 'package:advisor/3_application/pages/advisor/cubit/advisor_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I; //service locator

//register all the layers here
Future<void> init() async {
  //application layer(which is bloc)
  sl.registerFactory(() => AdvisorCubit(advisorUsecase: sl()));

  //domain layer
  sl.registerFactory(() => AdviceUsecase(adviceRepo: sl()));

  //datalayer
  //in the AdviceRepoImpli we have AdviceRepo as abstract class so here we will have to specify it
  sl.registerFactory<AdviceRepo>(
    () => AdviceRepoImpli(adviceRemoteDatasource: sl()),
  );
  sl.registerFactory<AdviceRemoteDatasource>(
    () => AdviceRemoteDatasourceImpl(client: sl()),
  );
  //externals
  sl.registerFactory(() => http.Client());
}
