part of 'advisor_bloc.dart';

@immutable
sealed class AdvisorState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AdvisorInitial extends AdvisorState {}

final class AdvisorLoadingState extends AdvisorState {}

//here we need props to campare objects because here attribute is present
final class AdvisorLoadedState extends AdvisorState {
  final String advice;

  AdvisorLoadedState({required this.advice});

  @override
  List<Object?> get props => [advice];
}

final class AdvisorErrorState extends AdvisorState {
  final String errorMsg;

  AdvisorErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}
