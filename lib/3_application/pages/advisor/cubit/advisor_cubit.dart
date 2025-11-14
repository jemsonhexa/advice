import 'package:advisor/2_domain/failures/failures.dart';
import 'package:advisor/2_domain/usecases/advice_usecase.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'advisor_state.dart';

//put consts always top of class

const serverErrorMsg = 'Oops! API Error occurred, please try again';
const cacheErrorMsg = 'Oops! Cache error occurred, please try again';
const defaultErrorMsg = 'Oops! Something went wrong, please try again';

class AdvisorCubit extends Cubit<AdvisorCubitState> {
  AdvisorCubit() : super(AdvisorInitial());

  final AdviceUsecase advisorUsecase = AdviceUsecase();
  //here we will have functions
  void adviceRequested() async {
    emit(AdvisorLoadingState());
    //here we call the use case(use case is where buss.logic occures)
    final failureOrAdvice = await advisorUsecase.getAdvice();
    // debugPrint("Fake advice trigerred");
    // next execute business logic like get a advice after 3 sec
    //await Future.delayed(Duration(seconds: 2), () {});
    // debugPrint('Got advice');

    failureOrAdvice.fold(
      (failure) =>
          emit(AdvisorErrorState(errorMsg: _mapFailuretoMessage(failure))),
      (advice) => emit(AdvisorLoadedState(advice: advice.advice)),
    );
  }

  String _mapFailuretoMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverErrorMsg;
      case CacheFailure:
        return cacheErrorMsg;
      default:
        return defaultErrorMsg;
    }
  }
}
