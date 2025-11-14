import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'advisor_event.dart';
part 'advisor_state.dart';

class AdvisorBloc extends Bloc<AdvisorEvent, AdvisorState> {
  AdvisorBloc() : super(AdvisorInitial()) {
    //when user pres get advice this will get triggered
    on<AdvisorEvent>((event, emit) async {
      //emit loading state first
      emit(AdvisorLoadingState());
      debugPrint("Fake advice trigerred");

      // next execute business logic like gethhh advice after 3 sec
      await Future.delayed(Duration(seconds: 3), () {});
      debugPrint('Got advice');

      //emit the LodedState
      emit(AdvisorLoadedState(advice: "A Fake Advice recieved"));
      //error
      /// emit(AdvisorErrorState(errorMsg: "Got Error"));
    });
  }
}
