import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:advisor/2_domain/failures/failures.dart';
import 'package:advisor/2_domain/usecases/advice_usecase.dart';

part 'advisor_state.dart';

//put consts always top of class

const serverErrorMsg = 'Oops! API Error occurred, please try again';
const cacheErrorMsg = 'Oops! Cache error occurred, please try again';
const defaultErrorMsg = 'Oops! Something went wrong, please try again';

class AdvisorCubit extends Cubit<AdvisorCubitState> {
  final AdviceUsecase advisorUsecase;
  AdvisorCubit({required this.advisorUsecase}) : super(AdvisorInitial());

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

  // AdvisorCubit copyWith({AdviceUsecase? advisorUsecase}) {
  //   return AdvisorCubit(advisorUsecase: advisorUsecase ?? this.advisorUsecase);
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{'advisorUsecase': advisorUsecase};
  // }

  // factory AdvisorCubit.fromMap(Map<String, dynamic> map) {
  //   return AdvisorCubit(
  //     advisorUsecase: AdviceUsecase.fromMap(
  //       map['advisorUsecase'] as Map<String, dynamic>,
  //     ),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory AdvisorCubit.fromJson(String source) =>
  //     AdvisorCubit.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() => 'AdvisorCubit(advisorUsecase: $advisorUsecase)';

  // @override
  // bool operator ==(covariant AdvisorCubit other) {
  //   if (identical(this, other)) return true;

  //   return other.advisorUsecase == advisorUsecase;
  // }

  // @override
  // int get hashCode => advisorUsecase.hashCode;
}
